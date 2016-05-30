module ('menu', package.seeall)
local anim, 		  controle, 		 engine, 		 gameObject,		    score			  ,keyListener
	= require'anim', require'controle', require'engine',require 'gameObject', require 'score',require'keyListener'

status = 'abertura';
eng = nil;
bkgMenu = nil;
bkgAbertura = nil;
bka = nil;
texto = '';
abertura = nil;
iniciarJogo = nil;
carregaJogo = nil;
foco = 1;
menuAtual = nil;
op1 = {};
apontador = nil;


function init(engin, loadGame, initGame)

	eng = engin;
	iniciarJogo = initGame;
	carregaJogo = loadGame;

	bkgMenu = gameObject.GameObject:new();
	bkgMenu:setAlive(true);
	bkgMenu:setSprite( 'sprites/menu.png' ,  640, 480, 640, 480);
	bkgMenu:getSprite():nextFrame();
	bkgMenu:setPosicao({0,0});

	o1 = gameObject.GameObject:new();
	o1:setAlive(true);
	o1:setSprite( 'sprites/op1.png' ,  640, 480, 640, 480);
	o1:getSprite():nextFrame();
	o1:setPosicao({304,100});

	table.insert(op1,o1);

	o2 = gameObject.GameObject:new();
	o2:setAlive(true);
	o2:setSprite( 'sprites/op2.png' ,  640, 480, 640, 480);
	o2:getSprite():nextFrame();
	o2:setPosicao({304,160});

	table.insert(op1,o2);

	o3 = gameObject.GameObject:new();
	o3:setAlive(true);
	o3:setSprite( 'sprites/op3.png' ,  640, 480, 640, 480);
	o3:getSprite():nextFrame();
	o3:setPosicao({304,220});

	table.insert(op1,o3);

	apontador = gameObject.GameObject:new();
	apontador:setAlive(true);
	apontador:setSprite( 'sprites/apontador.png' ,  41, 32, 41, 32);
	apontador:getSprite():nextFrame();
	apontador:setPosicao({340,132});



	keyListener.startListener(left, right, up, down, ok, exit);

	bkgControles = gameObject.GameObject:new();
	bkgControles:setAlive(true);
	bkgControles:setSprite( 'sprites/bg_controle.png' ,  640, 480, 640, 480);
	bkgControles:getSprite():nextFrame();
	bkgControles:setPosicao({0,0});

	bkgInfos = gameObject.GameObject:new();
	bkgInfos:setAlive(true);
	bkgInfos:setSprite( 'sprites/bg_equipe.png' ,  640, 480, 640, 480);
	bkgInfos:getSprite():nextFrame();
	bkgInfos:setPosicao({0,0});

	eng:timer(2000,function()
					bkgAbertura = gameObject.GameObject:new();
					bkgAbertura:setAlive(true);
					bkgAbertura:setSprite( 'sprites/bg_inicio.png' ,  640, 480, 640, 480);
					bkgAbertura:getSprite():nextFrame();
					bkgAbertura:setPosicao({0,0});

					iniciaAbertura();
				   end);
	eng:timer(10000,function()
						if status == 'abertura' then
							status = 'op1';
							menuAtual = op1;
							writeMenu();
						end
					end);
end

function reinit()
	keyListener.restartListener();
	status = 'op1';
	menuAtual = op1;
	writeMenu();
end

function left()
	if string.len(status) > 3 and status~='abertura' then
		status = string.sub(status, 0 , string.len(status)-1);
	end
	writeMenu();
end

function right()
	ok();
end

function up()
	if status ~= 'abertura' then
		if foco > 1 then
			foco = foco -1;
		else
			foco = #menuAtual;
		end
	end
	writeMenu();
end

function down()
	if status ~= 'abertura' then
		if foco < #menuAtual then
			foco = foco +1;
		else
			foco = 1;
		end
	end
	writeMenu();
end

function ok()
	if status == 'abertura' then
		status = 'op1';
		menuAtual = op1;
		writeMenu();
	elseif status == 'op1' then
		status = 'op1'..foco;
		writeMenu();
	end
end

function exit()
	print('erro propo'..{{}});
end

function iniciaAbertura()
	eng:limpar();
	eng:buffer(bkgAbertura);
	eng:atualizar();
end

function writeMenu()
	eng:limpar();
	eng:buffer(bkgMenu);
	if status == 'op1' then
		for i = 1, #op1 do
			--eng:buffer(op1[i]);
			if foco == i then
				local x,y = op1[i]:getPosicao()[1],op1[i]:getPosicao()[2];
				x = x - 40;
				apontador:setPosicao({x,y});
				eng:buffer(apontador);
			end
		end
	elseif status == 'op11' then
		carregaJogo();
		eng:timer(2000,iniciarJogo);
		stop();

		eng:exibeTexto(200, 400, 'Loading...', 50);
	elseif status == 'op12' then
		eng:buffer(bkgControles);
	elseif status == 'op13' then
		eng:buffer(bkgInfos);
	end
	eng:atualizar();
end

function sobre()

end

function stop()
	keyListener.stopListener();
end
