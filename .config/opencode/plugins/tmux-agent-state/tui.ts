import { execFile } from "node:child_process"
import { Plugin } from "@opencode/plugin/tui"

const PANE = process.env.TMUX_PANE
const REPORTER = `${process.env.HOME}/.bin/tmux-agent-state`

export default Plugin.define({
  id: "tmux-agent-state",
  setup(context) {
    if (!PANE) return

    const busySessions = new Set<string>()
    const pendingInputs = new Set<string>()

    const report = (state: string) => {
      execFile(REPORTER, [state, PANE], () => {})
    }

    const visibleSessionIDs = () => {
      const route = context.ui.router.current()
      const tabs = context.ui.tabs.enabled() ? context.ui.tabs.list().map((tab) => tab.sessionID) : []
      return new Set(route.type === "session" ? [...tabs, route.sessionID] : tabs)
    }

    const isOwnSession = (sessionID: string) => visibleSessionIDs().has(context.data.session.root(sessionID) ?? sessionID)

    const settleInput = (inputID: string) => {
      if (!pendingInputs.delete(inputID) || pendingInputs.size > 0) return
      report(busySessions.size > 0 ? "busy" : "clear")
    }

    const awaitInput = (sessionID: string, inputID: string) => {
      if (!isOwnSession(sessionID)) return
      pendingInputs.add(inputID)
      report("waiting")
    }

    const startExecution = (sessionID: string) => {
      if (!isOwnSession(sessionID)) return
      busySessions.add(sessionID)
      if (pendingInputs.size === 0) report("busy")
    }

    const endExecution = (sessionID: string, state: "done" | "error") => {
      if (!busySessions.delete(sessionID)) return
      if (state === "error") return report("error")
      if (busySessions.size > 0) return
      pendingInputs.clear()
      report("done")
    }

    const unsubscribers = [
      context.data.on("permission.asked", (event) => awaitInput(event.data.sessionID, event.data.id)),
      context.data.on("permission.replied", (event) => settleInput(event.data.requestID)),
      context.data.on("form.created", (event) => awaitInput(event.data.form.sessionID, event.data.form.id)),
      context.data.on("form.replied", (event) => settleInput(event.data.id)),
      context.data.on("form.cancelled", (event) => settleInput(event.data.id)),
      context.data.on("session.execution.started", (event) => startExecution(event.data.sessionID)),
      context.data.on("session.execution.succeeded", (event) => endExecution(event.data.sessionID, "done")),
      context.data.on("session.execution.interrupted", (event) => endExecution(event.data.sessionID, "done")),
      context.data.on("session.execution.failed", (event) => endExecution(event.data.sessionID, "error")),
    ]

    return () => unsubscribers.forEach((unsubscribe) => unsubscribe())
  },
})
