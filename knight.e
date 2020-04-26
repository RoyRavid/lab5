note
	description: "Summary description for {KNIGHT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KNIGHT

inherit
	ENTITY
create
	make

feature -- init
	make
		do
			row := 1
			col := 1
		end
feature -- attributes
	row, col: INTEGER

feature --commands
--	init_loc(rowi, coli: INTEGER)
--		do
--			row := rowi
--			col := coli
--		end
	set_loc(inp: TUPLE[INTEGER_32 , INTEGER_32])
		do
			row := inp.integer_item (1)
			col := inp.integer_item (2)
		end

feature -- queries
	move(input: TUPLE[INTEGER, INTEGER]): BOOLEAN
		do
			Result := FALSE
			if  input[1] ~ (row + 1) then
				if input[2] ~ (col + 2) or input[2] ~ (col - 2) then
					Result := TRUE
				end
			elseif input[1] ~ (row - 1) then
				if input[2] ~ (col + 2) or input[2] ~ (col - 2) then
					Result := TRUE
				end
			elseif input[1] ~ (row + 2) then
				if input[2] ~ (col + 1) or input[2] ~ (col - 1) then
					Result := TRUE
				end
			elseif input[1] ~ (row - 2) then
				if input[2] ~ (col + 1) or input[2] ~ (col - 1) then
					Result := TRUE
				end
			end
		end
end
