require("bitstring")
local bs = bitstring
function unpackstring(bin)
	local len = bs.unpack("8:int",bin)
	if(len < 0xFF) then
		local len,str=bs.unpack("8:int,rest:bin",bin)
		return str
	end
	local len = bs.unpack("16:int",bin)
	if(len < 0xFFFE) then 
		local len,str=bs.unpack("16:int,rest:bin",bin)
		return str
	end
	local len,str=bs.unpack("32:int,rest:bin",bin)
	return str
end

function packstring(str)
	local len=#str
	if(len < 0xFF) then
		return bs.pack("8:int,all:bin",len,str)	
	elseif(len < 0xFFFE) then
		return bs.pack("16:int,all:bin",len,str)	
	else
		return bs.pack("32:int,all:bin",len,str)	
	end
end


local result = packstring(string.rep("a",1024))
print(bs.hexstream(result))
local result1 = unpackstring(result)
print(#result1)






