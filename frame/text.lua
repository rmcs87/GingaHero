module ('text', package.seeall)

local pressed = -1
local nova = true
local add = true
local char = ''
local apertos = 0
local nf = nil
local temporizador = nil;
local formato = 1;

local MAP = 
{
	{
			 { '1', '.', ',' },
			 { 'a', 'b', 'c', '2' },
			 { 'd', 'e', 'f', '3' },
			 { 'g', 'h', 'i', '4' },
			 { 'j', 'k', 'l', '5' },
			 { 'm', 'n', 'o', '6' },
			 { 'p', 'q', 'r', 's', '7' },
			 { 't', 'u', 'v', '8' },
			 { 'w', 'x', 'y', 'z', '9' },
			 { '0' }
	},
	{
			 { '1', '.', ',' },
			 { 'A', 'B', 'C', '2' },
			 { 'D', 'E', 'F', '3' },
			 { 'G', 'H', 'I', '4' },
			 { 'J', 'K', 'L', '5' },
			 { 'M', 'N', 'O', '6' },
			 { 'P', 'Q', 'R', 'S', '7' },
			 { 'T', 'U', 'V', '8' },
			 { 'W', 'X', 'Y', 'Z', '9' },
			 { '0' }
	}
}

function f()
	pressed = -1;
	nova = true;
	add =false;
	char = '';
	apertos = 0;
end


function caracter(tecla)
	if tecla == 'CURSOR_LEFT' then
		pressed = -1;
		nova = true;
		add =false;
		char = '';
		apertos = 0;
	elseif tecla == 'CURSOR_RIGHT' then
		add = true;
		char =' ';
		pressed = -1;
		nova = true;
		apertos = 0;
	elseif tecla=='1' or tecla=='2' or tecla=='3' or tecla=='4' or tecla=='5' or tecla=='6' or tecla=='7' or tecla=='8' or tecla=='9' or tecla=='0' then		
		if pressed ~= -1 then
			if apertos == #MAP[formato][tecla+0] then
				apertos=0;
			end
			if pressed == tecla+0 then
				apertos = apertos+1;
				pressed = tecla+0;
				add = false;
				nova = false;
				char = MAP[formato][pressed][apertos];
			else
				apertos = 1;
				pressed = tecla+0;
				add = true;
				nova = false;
				char = MAP[formato][pressed][apertos];
			end	
		else	
			apertos = apertos+1;
			pressed = tecla+0;
			add = true;
			nova = false;
			char = MAP[formato][pressed][apertos];
		end
	elseif tecla == 'CURSOR_UP' then
		formato = 2;
		return true,'';
	elseif tecla == 'CURSOR_DOWN' then
		formato = 1;
		return true,'';
	end
	
	if temporizador then 
		temporizador();
	end
	temporizador = event.timer(1000,f);

	return add, char;
end
