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
#   hubot show project <project> - Show details of an Anthill project.
#   hubot grep projects <query> - Displays all Anthill projects with names that match <query>.

exec = require('child_process').exec
hilltop = (commands, cb) ->
  exec process.env.HUBOT_HILLTOP_PATH + " " + commands, (error, stdout, stderr) ->
    return_text = stdout
    return_text = stderr if error || stderr.length
    cb return_text

module.exports = (robot) ->
  robot.respond /show project (.+)/i, (msg) ->
    hilltop "project show \"#{msg.match[1]}\"", (output) ->
      msg.send output.replace /\s+$/g, ""

  robot.respond /grep projects (.+)/i, (msg) ->
    hilltop "project list", (output) ->
      projects = []
      filter = new RegExp(msg.match[1], 'i')
      projects = output.split('\n').filter (p) -> filter.test p
      msg.send projects.join('\n').replace /\s+$/g, ""

