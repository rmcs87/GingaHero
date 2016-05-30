module ('audio', package.seeall)

Audio = {
			playing = false,
			paused = false,
			muted = false,
			id = ''
		}
Class_Metatable = { __index = Audio }

function Audio:new ()
    return setmetatable ( {}, Class_Metatable )
end

--Pausa o audio
function Audio:pause()
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'pause',
		}
		self.paused = true;
		self.playing = false;
	else
		print('Audio OFF');
	end
end

--Pausa o audio
function Audio:unPause()
	if self.playing == false and self.paused == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'resume',
		}
		self.paused = false;
		self.playing = true;
	else
		--print('Audio OFF');
	end
end

--Diz a qual audio se refere
function Audio:setAudio(sound)
	self.id = sound;
	event.post{
		class  = 'ncl',
		type   = 'presentation',
		label   = self.id ..'Start',
		action = 'start',
	}
end

--Inicia audio
function Audio:start()
	if self.playing == false and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'start',
		}
		self.playing = true;
	else
		--print('Audio ja iniciado');
	end
end

--Coloca audio no comeco
function Audio:stop()
	if self.playing == true or self.paused == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'stop',
		}
		self.playing = false;
		self.paused = false;
	else
		--print('Audio off');
	end
end

--Modo mudo  Como foi iniciado em outro lugar, da erro
function Audio:mute()
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'start',
		}
		self.muted = true;
	else
		--print('Audio off');
	end
end

--Coloca em mudo por um certo tempo
function Audio:muteT(tempo)
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'start',
		}
		self.muted = true;
		event.timer(tempo,
			function ()
				event.post{
					class  = 'ncl',
					type   = 'presentation',
					label   = self.id ..'Mute',
					action = 'stop',
				}
				self.muted = false;
			end

		);
	else
		--print('Audio off');
	end
end

--Tira de mudo
function Audio:unMute()
	if self.muted == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'stop',
		}
		self.muted = false;
	else
		--print('Audio off');
	end
end

function Audio:isMuted()
	return self.muted;
end

function Audio:isPlaying()
	return self.playing;
end

function Audio:isPaused()
	return self.paused;
end
