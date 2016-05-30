module ('sprite', package.seeall)

Sprite = {
		img = nil,
		estados = 0,
		estadoAtual = 0,
		frames = 0,
		frameAtual = -1,
		widthT = 0,
		heightT = 0,
		widthF = 0,
		heightF = 0,
	}
Class_Metatable = { __index = Sprite }

function Sprite:new (caminho , tw , th , fw , fh )

	local temp = {}

    setmetatable ( temp, Class_Metatable )

	temp.img = canvas:new(caminho);
	temp.widthT = tw;
	temp.heightT = th;
	temp.widthF = fw;
	temp.heightF = fh;

	temp.estados = tw/fw;
	temp.frames = th/fh;

	return temp;
end

--Retorna o canvas contendo a imagem atual do Sprite
function Sprite:getCanvas()
	return self.img;
end

function Sprite:getDimensao()
	return self.widthF, self.heightF;
end

--Diz qual o estado (animação) deve ser executada
function Sprite:setEstado(novoEstado)

	self.estadoAtual = novoEstado;
	if self.frameAtual < self.frames-1 then
		self.frameAtual = self.frameAtual + 1;
	else
		self.frameAtual = 0;
	end

	self.img:attrCrop (
				self.estadoAtual* self.widthF ,
				self.frameAtual * self.heightF,
				self.widthF ,
				self.heightF);

end

--Diz qual animação esta sendo utilizada
function Sprite:getEstado()

	return self.estadoAtual;

end

--Muda o canvas para o próximo Frame
function Sprite:nextFrame()

	if self.frameAtual < self.frames-1 then
		self.frameAtual = self.frameAtual + 1;
	else
		self.frameAtual = 0;
	end

	self.img:attrCrop (
				self.estadoAtual* self.widthF ,
				self.frameAtual * self.heightF,
				self.widthF ,
				self.heightF);
end
