module ('colision', package.seeall)

Colision = {

		}
Class_Metatable = { __index = Colision }

function Colision:new ()
    return setmetatable ( {}, Class_Metatable )
end

--Colisão simples por retangulo
function Colision:boxColisionByPair(obj1, obj2)
	
	if obj1 == nil or obj2 == nil then
		return false;
	end 
	
	local a = {};
	local b = {};
	local temp;
	a.w, a.h = obj1:getSprite():getDimensao();
	temp = obj1:getPosicao();
	a.x, a.y = temp[1] , temp[2]; 
	
	b.w, b.h = obj2:getSprite():getDimensao();
	temp = obj2:getPosicao();
	b.x, b.y = temp[1] , temp[2];
	 
	if b.x + b.w < a.x then
		return false;
	elseif b.x > a.x + a.w then
		return false;
	elseif b.y + b.h < a.y then
		return false;
	elseif b.y > a.y + a.h then
		return false;
	end
	return true;
end
