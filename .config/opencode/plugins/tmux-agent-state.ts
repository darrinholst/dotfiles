import type { Plugin } from "@opencode-ai/plugin"

const PANE = process.env.TMUX_PANE
const REPORTER = `${process.env.HOME}/.bin/tmux-agent-state`

const NEEDS_INPUT = new Set([
  "permission.asked",
  "permission.v2.asked",
  "question.asked",
  "question.v2.asked",
])

const INPUT_SETTLED = new Set([
  "permission.replied",
  "permission.v2.replied",
  "question.replied",
  "question.v2.replied",
  "question.rejected",
])

export const TmuxAgentState: Plugin = async ({ $ }) => {
  if (!PANE) return {}

  const busySessions = new Set<string>()
  let blocked = false

  const report = async (state: string) => {
    await $`${REPORTER} ${state} ${PANE}`.quiet().nothrow()
  }

  const handle = async (type: string, properties: Record<string, any>) => {
    if (NEEDS_INPUT.has(type)) {
      blocked = true
      return report("waiting")
    }

    if (INPUT_SETTLED.has(type)) {
      blocked = false
      return report(busySessions.size > 0 ? "busy" : "clear")
    }

    if (type === "session.error") return report("error")

    if (type === "session.status") {
      if (properties.status?.type !== "busy") {
        busySessions.delete(properties.sessionID)
        return
      }
      busySessions.add(properties.sessionID)
      if (!blocked) return report("busy")
      return
    }

    if (type === "session.idle") {
      busySessions.delete(properties.sessionID)
      blocked = false
      if (busySessions.size === 0) return report("done")
    }
  }

  return {
    event: async ({ event }) => handle(event.type, (event as any).properties ?? {}),
    "chat.message": async ({ sessionID }) => {
      busySessions.add(sessionID)
      if (!blocked) await report("busy")
    },
  }
}
