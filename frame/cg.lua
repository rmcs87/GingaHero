module ('cg', package.seeall)

CG = {
			playing = false,
			paused = false,
			muted = false,
			id = ''
		}
Class_Metatable = { __index = CG }

function CG:new ()
    return setmetatable ( {}, Class_Metatable )
end

--Pausa o audio
function CG:pause()
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
		--print('Audio OFF');
	end
end

--Pausa o audio
function CG:unPause()
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
function CG:setVideo(video)
	self.id = video;
	event.post{
		class  = 'ncl',
		type   = 'presentation',
		label   = self.id ..'Start',
		action = 'start',
	}
end

--Inicia audio
function CG:start()
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
function CG:stop()
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


function CG:isPlaying()
	return self.playing;
end

function CG:isPaused()
	return self.paused;
end
