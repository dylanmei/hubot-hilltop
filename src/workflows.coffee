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
#   hubot show workflow <project> <workflow> - Show details of an Anthill workflow.

exec = require('child_process').exec
hilltop = (commands, cb) ->
  exec process.env.HUBOT_HILLTOP_PATH + " " + commands, (error, stdout, stderr) ->
    return_text = stdout
    return_text = stderr if error || stderr.length
    cb return_text

module.exports = (robot) ->
  robot.respond /show workflow (.+) (.+)/i, (msg) ->
    hilltop "workflow show \"#{msg.match[1]}\" \"#{msg.match[2]}\"", (output) ->
      msg.send output.replace /\s+$/g, ""
