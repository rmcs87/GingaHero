module ('engine', package.seeall)

Engine = {
		tempi = nil,
	}
Class_Metatable = { __index = Engine }

function Engine:new ()

	local temp = {}

    setmetatable ( temp, Class_Metatable )

	return temp;
end

function Engine:buffer(obj)
	if obj:isAlive() == true then
		local temp = obj:getPosicao();
		canvas:compose(temp[1],temp[2],obj:getSprite():getCanvas());
	end
end

function Engine:getCanvasSize()
	local w,h = canvas:attrSize();
	return w,h;
end

function Engine:limpar()
	canvas:clear();
end

function Engine:atualizar()
	canvas:flush();
end

function Engine:timer(tempo,func)
	event.timer(tempo,func);
end

function Engine:exibeTexto(x, y, texto, size)
	canvas:attrColor('white');
	canvas:attrFont('vera', size, 'bold');
	canvas:drawText(x, y, texto);
	canvas:attrColor('black');
end
