# Description:
#   Anthill funcitons via Hilltop
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HILLTOP_PATH
#
# Commands:
#   hubot build <project> <workflow> - Build an originating Anthill workflow.
#   hubot show build <buildlife> - Show details of an Anthill buildlife.
#   hubot <workflow> <buildlife> to|in <environment> - Run a workflow against a buildlife in an environment.

exec = require('child_process').exec
hilltop = (commands, cb) ->
  exec process.env.HUBOT_HILLTOP_PATH + " " + commands, (error, stdout, stderr) ->
    return_text = stdout
    return_text = stderr if error || stderr.length
    cb return_text

module.exports = (robot) ->
  robot.respond /show build (\d+)/i, (msg) ->
    hilltop "build show #{msg.match[1]}", (output) ->
      msg.send output.replace /\s+$/g, ""

  robot.respond /build (.+) (.+)/i, (msg) ->
    hilltop "build new \"#{msg.match[1]}\" \"#{msg.match[2]}\"", (output) ->
      msg.send output.replace /\s+$/g, ""

  robot.respond /(.+) (\d+) (?:to|in) (.+)/i, (msg) ->
    hilltop "build run \"#{msg.match[2]}\" \"#{msg.match[1]}\" \"#{msg.match[3]}\"", (output) ->
      msg.send output.replace /\s+$/g, ""
