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
#   hubot build me <project> <workflow> - Build an originating Anthill workflow.
#   hubot show build <buildlife> - Show details of an Anthill buildlife.

exec = require('child_process').exec
hilltop = (commands, cb) ->
  exec process.env.HUBOT_HILLTOP_PATH + " " + commands, (error, stdout, stderr) ->
    return_text = stdout
    return_text = stderr if error || stderr.length
    cb return_text

module.exports = (robot) ->
  robot.respond /build me (.+) (.+)/i, (msg) ->
    hilltop "build start \"#{msg.match[1]}\" \"#{msg.match[2]}\"", (output) ->
      msg.send output.replace /\s+$/g, ""

  robot.respond /show build (\d+)/i, (msg) ->
    hilltop "build show #{msg.match[1]}", (output) ->
      msg.send output.replace /\s+$/g, ""
