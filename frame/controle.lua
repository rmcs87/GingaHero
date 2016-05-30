module ('controle', package.seeall)

botoes = {
	--[[RED = {
		pressed = false,
		released = false,
	},
	GREEN = {
		pressed = false,
		released = false,
	},
	BLUE = {
		pressed = false,
		released = false,
	},
	YELLOW = {
		pressed = false,
		released = false,
	},]]--
	x = {
		pressed = false,
		released = false,
	},
	c = {
		pressed = false,
		released = false,
	},
	b = {
		pressed = false,
		released = false,
	},
	v = {
		pressed = false,
		released = false,
	},
	['0'] = {
		pressed = false,
		released = false,
	},
	['1'] = {
		pressed = false,
		released = false,
	},
	['2'] = {
		pressed = false,
		released = false,
	},
	['3'] = {
		pressed = false,
		released = false,
	},
	['4'] = {
		pressed = false,
		released = false,
	},
	['5'] = {
		pressed = false,
		released = false,
	},
	['6'] = {
		pressed = false,
		released = false,
	},
	['7'] = {
		pressed = false,
		released = false,
	},
	['8'] = {
		pressed = false,
		released = false,
	},
	['9'] = {
		pressed = false,
		released = false,
	},
	MENU = {
		pressed = false,
		released = false,
	},
	INFO = {
		pressed = false,
		released = false,
	},
	CURSOR_DOWN = {
		pressed = false,
		released = false,
	},
	CURSOR_UP = {
		pressed = false,
		released = false,
	},
	CURSOR_LEFT = {
		pressed = false,
		released = false,
	},
	CURSOR_RIGHT = {
		pressed = false,
		released = false,
	},
	ENTER = {
		pressed = false,
		released = false,
	},
}

--Limpa o estado atual do controle
function cleanState()
	table.foreach(botoes,
					function(tabela,valor)
						valor.pressed = false;
						valor.released = false;
					end
				)
end

--Verifica se a tecla é compativel com o sistema
function teclaValida(tecla)
	if tecla == 'ENTER' or tecla == 'CURSOR_RIGHT' or tecla == 'CURSOR_LEFT' or tecla == 'CURSOR_UP'
		or tecla == 'CURSOR_DOWN' or tecla == 'INFO' or tecla == 'ENTER' or tecla == 'MENU'
		or tecla == '9' or tecla == '8' or tecla == '7' or tecla == '6' or tecla == '5'
		or tecla == '4' or tecla == '3' or tecla == '2' or tecla == '1' or tecla == '0'
		--or tecla == 'RED' or tecla == 'GREEN' or tecla == 'YELLOW' or tecla == 'BLUE'
		or tecla == 'x' or tecla == 'c' or tecla == 'v' or tecla == 'b'
			then
		return true
	else
		return false
	end
end

--Copia tabela
function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end

        return setmetatable(new_table, _copy( getmetatable(object)))
    end
    return _copy(object)
end

--Retorna copia da tabela
function getState ()
	return deepcopy(botoes)
end

-- Funcao de tratamento de eventos:
function keyListener (evt)
	if evt.class == 'key' and teclaValida(evt.key) then
		if evt.type == 'press'then
			botoes[evt.key].pressed = true;
		end
		if evt.type == 'release'then
			botoes[evt.key].released = true;
		end
	end
end
event.register(keyListener)
