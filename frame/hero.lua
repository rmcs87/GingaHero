module ('hero', package.seeall)

local anim, 		  controle, 		 engine, 		 sprite,		 gameObject,		  colision		   , audio		   ,musica			, score			  ,menu
	  = require'anim', require'controle', require'engine',require'sprite',require 'gameObject',require'colision', require'audio', require 'musica', require 'score',require'menu'

colisao = nil;
eng = nil;

padNew = nil;
padOld = nil;

background = nil;
guitarra = nil;
base = {};
baseCount = {5,5,5,5};
notas = {{},{},{},{}};
seqs = {{},{},{},{}};
inSeq = false;
seqTam = 0;
finished = false;

errorAudio = nil;
guitarAudio = nil;
musicAudio = nil;

aCount = 0;
aps = nil;
apsError = 0;

function criaBase()
	base[1] = gameObject.GameObject:new();
	base[1]:setAlive(true);
	base[1]:setSprite( 'sprites/base-red.png' , 218 , 45 , 73 , 45);
	base[1]:getSprite():nextFrame();
	base[1]:setPosicao({205,409});

	base[2] = gameObject.GameObject:new();
	base[2]:setAlive(true);
	base[2]:setSprite( 'sprites/base-green.png' , 218 , 45 , 73 , 45);
	base[2]:getSprite():nextFrame();
	base[2]:setPosicao({267,409});

	base[3] = gameObject.GameObject:new();
	base[3]:setAlive(true);
	base[3]:setSprite( 'sprites/base-yellow.png' , 218 , 45 , 73 , 45);
	base[3]:getSprite():nextFrame();
	base[3]:setPosicao({330,409});

	base[4] = gameObject.GameObject:new();
	base[4]:setAlive(true);
	base[4]:setSprite( 'sprites/base-blue.png' , 218 , 45 , 73 , 45);
	base[4]:getSprite():nextFrame();
	base[4]:setPosicao({391,409});

end

function init()

	pontos = gameObject.GameObject:new();
	pontos:setAlive(true);
	pontos:setSprite( 'sprites/pontuacao.png' , 506 , 318 , 506 , 318);
	pontos:getSprite():nextFrame();
	pontos:setPosicao({75,99});

	padNew = controle.getState();

	eng = engine.Engine:new();

	pontuacao = score.Score:new();

	colisao = colision.Colision:new();

	aps = 3.5;

	menu.init(eng,function()
					loadGame();
				end,
				function()
					initGame();
				end);
end

function loadGame()

	guitarra = gameObject.GameObject:new();
	guitarra:setAlive(true);
	guitarra:setSprite( 'sprites/guitar.png' , 640 , 480 , 640 ,  480);
	guitarra:getSprite():nextFrame();
	guitarra:setPosicao({0,0});

	criaBase();

	musicAudio = audio.Audio:new();
	musicAudio:setAudio('song');

	guitarAudio = audio.Audio:new();
	guitarAudio:setAudio('guitar');

end

function initGame()
	anim.start(update,draw);
	musicAudio:start();
	guitarAudio:start();
end

function criaNota(id)

	local temp = gameObject.GameObject:new();
	temp:setAlive(true);
	temp:setVelocidade({0,15});
	if id == 1 then
		temp:setSprite( 'sprites/red.png' , 63 , 42 , 63 , 42);
		temp:getSprite():nextFrame();
		temp:setPosicao({213,0});
		table.insert(notas[1],1,temp);
	elseif id == 2 then
		temp:setSprite( 'sprites/green.png' , 63 , 42 , 63 , 42);
		temp:getSprite():nextFrame();
		temp:setPosicao({275,0});
		table.insert(notas[2],1,temp);
	elseif id == 3 then
		temp:setSprite( 'sprites/yellow.png' , 63 , 42 , 63 , 42);
		temp:getSprite():nextFrame();
		temp:setPosicao({338,0});
		table.insert(notas[3],1,temp);
	else
		temp:setSprite( 'sprites/blue.png' ,63 , 42 , 63 , 42);
		temp:getSprite():nextFrame();
		temp:setPosicao({399,0});
		table.insert(notas[4],1,temp);
	end

end

function criaSeq(valor,id)

	for i = 1, valor do
		local temp = gameObject.GameObject:new();
		temp:setAlive(true);
		temp:setVelocidade({0,15});
		if id == 1 then
			temp:setSprite( 'sprites/bar_red.png' , 56 , 56 , 56 ,  56);
			temp:getSprite():nextFrame();
			temp:setPosicao({213,56 - i*56});
			temp:getSprite():setEstado(1);
			table.insert(seqs[1],i,temp);
		elseif id == 2 then
			temp:setSprite( 'sprites/bar_green.png' , 56 , 56 , 56 ,  56);
			temp:getSprite():nextFrame();
			temp:setPosicao({275,56 - i*56});
			temp:getSprite():setEstado(1);
			table.insert(seqs[2],i,temp);
		elseif id == 3 then
			temp:setSprite( 'sprites/bar_yellow.png' , 56 , 56 , 56 ,  56);
			temp:getSprite():nextFrame();
			temp:setPosicao({338,56 - i*56});
			temp:getSprite():setEstado(1);
			table.insert(seqs[3],i,temp);
		elseif id == 4 then
			temp:setSprite( 'sprites/bar_blue.png' , 56 , 56 , 56 ,  56);
			temp:getSprite():nextFrame();
			temp:setPosicao({399,56 - i*56});
			temp:getSprite():setEstado(1);
			table.insert(seqs[4],i,temp);
		end
	end

end

function getPrimeiraNota(id)
	local n = notas[id][#notas[id]];
	if n ~= nil or n == 0 then
		return n;
	else
		return nil;
	end
end

function getSeq(id)
	local s = seqs[id][1];
	if s ~= nil or s == 0 then
		return s;
	else
		return nil;
	end
end

function teclar()
	--Botão vermelha
	for i = 1,4 do
		if padNew[i..''].pressed == true then
			if inSeq then
				pontuacao:acertou();
			elseif colisao:boxColisionByPair(base[i] , getPrimeiraNota(i)) == true then
				if guitarAudio:isMuted() then
					guitarAudio:unMute();
				end
				pontuacao:acertou();
				base[i]:getSprite():setEstado(2);
				table.remove(notas[i]);
			elseif colisao:boxColisionByPair(base[i] , getSeq(i)) == true then
				if guitarAudio:isMuted() then
					guitarAudio:unMute();
				end
				pontuacao:acertou();
				base[i]:getSprite():setEstado(2);
				table.remove(seqs[i]);
				inSeq = true;
				for j = 1, #seqs[i] do
					seqs[i][j]:getSprite():setEstado(0);
				end
			else
				pontuacao:errou();
				base[i]:getSprite():setEstado(1);
				guitarAudio:mute();
			end;
		end
		if padOld[i..''].released == true then
			base[i]:getSprite():setEstado(0);
			for j = 1, #seqs[i] do
				seqs[i][j]:getSprite():setEstado(1);
			end
			inSeq = false;
		end
	end

	if padNew['5'].released == true then
		musicAudio:stop();
		guitarAudio:stop();
		anim.stop();

		eng:timer(2000,function()
					aCount = 0;
					aps = 3.5
					apsError = 0;
					notas = {{},{},{},{}};
					seqs = {{},{},{},{}};
					menu.reinit();
					musica.restart();
					pontuacao:clear();

				end);
	end

	--Travar app
	if padOld['6'].released == true then
		print('casa' ..  padOld['6'] );
	end

end

function update()

	padOld = padNew;
	padNew = controle.getState();
	controle.cleanState();

	teclar();

	if aCount + apsError >= aps then

		acorde = musica.proximaNota();
		if seqTam > 0 then
			seqTam = seqTam - 1;
		elseif seqTam == 0 then
			inSeq = false;
		end

		if acorde == nil then
			musicAudio:stop();
			guitarAudio:stop();
			finished = true;

			eng:timer(5000,function()
						aCount = 0;
						aps = 3.5
						apsError = 0;
						notas = {{},{},{},{}};
						seqs = {{},{},{},{}};
						menu.reinit();
						musica.restart();
						pontuacao:clear();
						finished = false;

					end);

			return ;

		end


		for key,nota in pairs(acorde) do
			if nota == 1 then
				criaNota(key);
			elseif nota > 1 then
				criaSeq(nota,key);
				seqTam = nota;
			end
		end
		musica.atualizaNota();
		apsError = apsError + aCount - aps;
		aCount = 0;
	else
		aCount = aCount + 1;
	end

	for i=1,4 do
		for j = 1, #notas[i] do
			local pos = notas[i][j]:getPosicao();

			notas[i][j]:setPosicao( {pos[1] , pos[2] + notas[i][j]:getVelocidade()[2]});

			if pos[2] > 410 then
				guitarAudio:mute();
				table.remove(notas[i])
				break;
			end
		end
	end
	for i=1,4 do
		for j = 1, #seqs[i] do
			local pos = seqs[i][j]:getPosicao();

			seqs[i][j]:setPosicao( {pos[1] , pos[2] + seqs[i][j]:getVelocidade()[2]});


			if pos[2] > 410 and inSeq == false then
				table.remove(seqs[i])
				break;
			end
		end
	end
end

function draw()
	eng:limpar();
	eng:buffer(guitarra);
	for i=1,4 do
		for j = 1, #notas[i] do
			eng:buffer(notas[i][j]);
		end
	end

	for i=1,4 do
		for j = 1, #seqs[i] do
			eng:buffer(seqs[i][j]);
		end
	end

	for i=1,4 do
		eng:buffer(base[i]);
	end

	eng:exibeTexto(10, 10, pontuacao:getHit() .. ' hit', 24);

	eng:exibeTexto(530, 10, pontuacao:getScore() .. '', 24);
	eng:exibeTexto(530, 40, pontuacao:getLevel() .. 'X', 28);

	if finished == true then
		eng:buffer(pontos);
		eng:exibeTexto(275, 200, pontuacao:getScore()..'', 35);
		eng:exibeTexto(283, 335, pontuacao:getHit() .. '', 35);
		anim.stop();
	end

	eng:atualizar();
end

init();
