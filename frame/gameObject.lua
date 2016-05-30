module ('gameObject', package.seeall)

local sprite = require'sprite'

GameObject = {
			alive  = false,
			centro = {0, 0},
			escala = 1,
			posicao = {0, 0},
			rotacao = 0,
			sentido = 0,
			sprite = nil,
			velocidade = {0,0},
			colidido = 0,
		}
Class_Metatable = { __index = GameObject }

function GameObject:new ()
    return setmetatable ( {}, Class_Metatable )
end

-- Retorna a escala
function GameObject:getEscala()
	return self.escala
end
function GameObject:setEscala(escala)
	self.escala = escala;
end

-- Retorna o centro
function GameObject:getCentro()
	return self.centro;
end
function GameObject:setCentro(centro)
	self.centro = centro;
end

-- Retorna a posição
function GameObject:getPosicao()
	return self.posicao;
end
function GameObject:setPosicao(posicao)
	self.posicao = posicao;
end

-- Retorna a rotação
function GameObject:getRotacao()
	return self.rotacao;
end
function GameObject:setRotacao(angulo)
	self.rotacao = angulo;
end

-- Retorna se ja foi colidido
function GameObject:getColidido()
	return self.rotacao;
end
function GameObject:setColidido(num)
	self.colidido = self.colidido + num;
end

-- Retorna o sentido
function GameObject:getSentido()
	return self.sentido;
end
function GameObject:setSentido(sentido)
	self.sentido = sentido;
end

-- Retorna o objecto sprite
function GameObject:getSprite()
	return self.sprite;
end
function GameObject:setSprite(caminho , tw , th , fw , fh )
	self.sprite = sprite.Sprite:new( caminho , tw , th , fw , fh);
end

-- Retorna a velocidade
function GameObject:getVelocidade()
	return self.velocidade;
end
function GameObject:setVelocidade(velocidade)
	self.velocidade = velocidade;
end

-- Retorna o estado de alive
function GameObject:isAlive()
	return self.alive;
end
function GameObject:setAlive(alive)
	self.alive = alive;
end
