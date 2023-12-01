assert(rb,"Run fbneo-training-mode.lua")

-- taken from http://lua-users.org/wiki/SaveTableToFile

--[[
	Save Table to File
	Load Table from File
	v 1.0
	
	Lua 5.2 compatible
	
	Only Saves Tables, Numbers and Strings
	Insides Table References are saved
	Does not save Userdata, Metatables, Functions and indices of these
	----------------------------------------------------
	table.save( table , filename )
	
	on failure: returns an error msg
	
	----------------------------------------------------
	table.load( filename or stringtable )
	
	Loads a table that has been saved via the table.save function
	
	on success: returns a previously saved table
	on failure: returns as second argument an error msg
	----------------------------------------------------
	
	Licensed under the same terms as Lua itself.
]]--
do
	-- declare local variables
	--// exportstring( string )
	--// returns a "Lua" portable version of the string
	local function exportstring( s )
		return string.format("%q", s)
	end
	
	local function exportboolean( b )
		return tostring( b ) 
	end

	--// The Save Function
	function table.save(  tbl,filename )
		local charS,charE = "   ","\n"
		local file,err = io.open( filename, "wb" )
		if err then return err end
		
		file:write("assert(rb,\"Run fbneo-training-mode.lua\")\n")
		-- initiate variables for save procedure
		local tables,lookup = { tbl },{ [tbl] = 1 }
		file:write( "return {"..charE )

		for idx,t in ipairs( tables ) do
			file:write( "-- Table: {"..idx.."}"..charE )
			file:write( "{"..charE )
			local thandled = {}

			for i,v in ipairs( t ) do
				thandled[i] = true
				local stype = type( v )
				-- only handle value
				if stype == "table" then
					if not lookup[v] then
						table.insert( tables, v )
						lookup[v] = #tables
					end
					file:write( charS.."{"..lookup[v].."},"..charE )
				elseif stype == "string" then
					file:write(  charS..exportstring( v )..","..charE )
				elseif stype == "number" then
					file:write(  charS..tostring( v )..","..charE )
				elseif stype == "boolean" then -- edit to original to allow saving booleans
					file:write( charS..exportboolean( v )..","..charE )
				end
			end

			for i,v in pairs( t ) do
				-- escape handled values
				if (not thandled[i]) then
				
					local str = ""
					local stype = type( i )
					-- handle index
					if stype == "table" then
						if not lookup[i] then
							table.insert( tables,i )
							lookup[i] = #tables
						end
						str = charS.."[{"..lookup[i].."}]="
					elseif stype == "string" then
						str = charS.."["..exportstring( i ).."]="
					elseif stype == "number" then
						str = charS.."["..tostring( i ).."]="
					elseif stype == "boolean" then -- edit to original to allow saving booleans
						str = charS.."["..exportboolean( i ).."]="
					end
				
					if str ~= "" then
						stype = type( v )
						-- handle value
						if stype == "table" then
							if not lookup[v] then
								table.insert( tables,v )
								lookup[v] = #tables
							end
							file:write( str.."{"..lookup[v].."},"..charE )
						elseif stype == "string" then
							file:write( str..exportstring( v )..","..charE )
						elseif stype == "number" then
							file:write( str..tostring( v )..","..charE )
						elseif stype == "boolean" then
							file:write( str..exportboolean( v )..","..charE )
						end
					end
				end
			end
			file:write( "},"..charE )
		end
		file:write( "}" )
		file:close()
	end
	
	--// The Load Function	
	function table.load( sfile )
	
		local fs = io.open( sfile , "r") -- edit to original 
		local str = fs:read( "*all" ) -- checking the contents of the config file to make sure its just a table
		fs:close()
		if str:sub(1,40) ~= "assert(rb,\"Run fbneo-training-mode.lua\")" then return nil end
	
		local ftables, err = loadfile( sfile )
		if err then return nil end
		local tables = ftables()
		for idx = 1,#tables do
			local tolinki = {}
			for i,v in pairs( tables[idx] ) do
				if type( v ) == "table" then
					tables[idx][i] = tables[v[1]]
				end
				if type( i ) == "table" and tables[i[1]] then
					table.insert( tolinki,{ i,tables[i[1]] } )
				end
			end
			-- link indices
			for _,v in ipairs( tolinki ) do
				tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
			end
		end
		return tables[1]
	end
-- close do
end

-- ChillCode
