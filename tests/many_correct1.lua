Dog = {}                                   -- 1.

function Dog:new()                         -- 2.
  local newObj = {sound = 'woof'}          -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
end

mrDog = Dog:new()                          -- 7.
mrDog:makeSound()  -- 'I say woof'         -- 8.