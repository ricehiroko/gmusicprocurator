# -*- coding: utf-8 -*-
# vim: set ts=2 sts=2 sw=2 :
#
###! Copyright (C) 2014 Mark Lee, under the GPL (version 3+) ###
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class gmp.PlayerView extends Backbone.View
  tagName: 'section'
  template: _.template($('#player-tpl').html())
  events:
    'click .play-pause': 'play_pause'
    'click .stop': 'stop'
  render: ->
    @$el.html(@template())
    @$play_pause = @$el.find('.play-pause > span')
    @$audio = @$el.children('audio')
    @audio = @$audio[0]
    @$audio.on 'pause', =>
      @$play_pause.removeClass('fa-pause').addClass('fa-play')
    @$audio.on 'play', =>
      @$play_pause.removeClass('fa-play').addClass('fa-pause')
    return this

  play: (url) ->
    if !!@audio.canPlayType
      if @audio.canPlayType('audio/mpeg')
        @audio.setAttribute('src', url)
        @audio.load()
      else
        window.alert 'You cannot play MP3s natively. Sorry.'
    else
      window.alert 'Cannot play HTML5 audio. Sorry.'

  play_pause: ->
    return false unless @audio.played.length
    if @$play_pause.hasClass('fa-play')
      @audio.play()
    else
      @audio.pause()
    return true

  stop: ->
    return false unless @audio.played.length
    @audio.pause() if @$play_pause.hasClass('fa-pause')
    @audio.currentTime = 0