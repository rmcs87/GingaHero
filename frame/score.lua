module ('score', package.seeall)

Score = {
		sequenceMax = 10, 		-- máximo de notas corretas em sequencia para aumentar o valor de nivel
		sequenceCurrent = 0, 	-- sequencia atual correta
		score = 0, 				-- score total
		level = 1, 				-- niveis 1, 2, 4, 6
		totalHit = 0,
		hit = 0,
		}
Class_Metatable = { __index = Score }

function Score:new ()
    return setmetatable ( {}, Class_Metatable )
end

function Score:acertou()
	self.sequenceCurrent = self.sequenceCurrent + 1;

	if self.sequenceCurrent == 10 and self.level < 6 then
		if self.level == 1 then
			self.level = self.level + 1;
		else
			self.level = self.level + 2;
		end

		self.sequenceCurrent = 0;
	end

	self.hit = self.hit + 1;
	self.score = self.score + self.level * 50;
end

function Score:errou()
	self.sequenceCurrent = 0;
	self.level = 1;
end

function Score:getScore()
	return self.score;
end

function Score:getLevel()
	return self.level;
end

function Score:getHit()
	return self.hit;
end

function Score:setTotalHit(th)
	self.totalHit = th;
end

function Score:clear()
	self.sequenceMax = 10;
	self.sequenceCurrent = 0;
	self.score = 0;
	self.level = 1;
	self.totalHit = 0;
	self.hit = 0;
end
