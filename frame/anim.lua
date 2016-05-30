module ('anim', package.seeall)

function start(update)
	update();
end

local config = {
				funcUpdate,
				funcDraw,
				running = false,					--Para controle da animacao
				NO_DELAYS_PER_YIELD = 100,			--delays maximos
				MAX_FRAME_SKIPS = 5,				--no. de frames que podem ser pulados na animcao
			}
local times = {
				before,timeDiff,sleep,after,
				overSleep = 0,
				delays = 0,
				period = 67,
				excess = 0,
			}

--Inicia tudo
function start(update,draw)
	config.funcUpdate = update;
	config.funcDraw = draw;
	config.running = true;
	times.before = event.uptime();
	run();
end

--Para o jogo
function stop()
	config.running = false;
	times.before = event.uptime();
	run();
end

--atualiza o jogo
function gameUpdate()
	config.funcUpdate();
end

-- atualiza a tela
function gameBuffer()
	config.funcDraw();
end

function run()
	if config.running then
		gameUpdate();
		gameBuffer();

		times.after = event.uptime();
		times.timeDiff = times.after - times.before;
		times.sleep = (times.period - times.timeDiff) - times.overSleep;

		if times.sleep > 0 then
			event.timer(times.sleep, runAux2);
		else
			times.overSleep = 0;
			times.delays = times.delays + 1;
			if times.delays >= config.NO_DELAYS_PER_YIELD then
				times.delays = 0;
				--liberar thread de for necessario em estudos futuros;
			end
			runAux();
		end

	end
end
--auxiliar para calculo de erros do timer
function runAux2()
	times.excess = times.excess - times.sleep;
	times.overSleep = (event.uptime() - times.after) - times.sleep;
	runAux();
end
function runAux()
	times.before = event.uptime();

	local skips = 0;
	while((times.excess > times.period) and (skips < config.MAX_FRAME_SKIPS)) do
		times.excess = times.excess - times.period;
		gameUpdate(); 		--update state but don't render
		skips= skips + 1;
	end

	run();
end
