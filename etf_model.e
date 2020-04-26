note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
	--		create s.make_empty
			i := 0
			j := 0
			create history.make_empty
			create init_string.make_empty
			create error_string.make_empty
			create board_str.make_empty
			create board.make_filled (create {SQUARE}.make ("_"),0,0)
			create history_args.make_empty
			create king.make
			create knight.make
			init_game
--			test_bool := FALSE
		end

feature -- model attributes
--	s : STRING
	i, j : INTEGER
	history: ARRAY[COMMAND]
	history_args: ARRAY[TUPLE[INTEGER, INTEGER]]
	init_string: STRING
	board: ARRAY2[SQUARE]
	board_str: STRING
	error_string: STRING
	king: KING
	knight: KNIGHT
--	test_bool : BOOLEAN


feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end
	reset
			-- Reset model state.
		do
			make
		end
	init_game
		do
			if not in_game then
				init_string := "  ok, K = King and N = Knight:"
			end
		end
	set_error_string(newstr: STRING)
		do
			error_string := newstr
		end
	play
		local
			king_sq, knight_sq: SQUARE

		do
--			knight.init_loc (board.height, board.width)
			create king_sq.make ("K")
			king_sq.set_location ([1,1])
			king.set_loc ([1,1])
			board[1,1] := king_sq

			create knight_sq.make ("N")
			knight_sq.set_location ([board.height, board.width])
			knight.set_loc ([board.height, board.width])
			board[board.height, board.width] := knight_sq

			init_string := "  ok:"
		end
	move_king(square: TUPLE[INTEGER, INTEGER])
		local
			row, col: INTEGER
			king_sq: SQUARE
		do
			row := square.integer_item (1)
			col := square.integer_item (2)
			init_string := "  ok:"
			if  in_game then
				create king_sq.make ("K")
				king_sq.set_location ([row, col])
				board[row, col] := king_sq
--				board.item (square.integer_item (1), square.integer_item (2)).replace_substring_all ("K","_")
				king.set_loc(square)

--				board.put ("K", square.integer_item (1), square.integer_item (2))
			end
		end
	move_knight(square: TUPLE[INTEGER, INTEGER])
		local
			row, col: INTEGER
			knight_sq: SQUARE
		do
			row := square.integer_item (1)
			col := square.integer_item (2)
			init_string := "  ok:"
			if in_game then
				create knight_sq.make ("N")
				knight_sq.set_location ([row, col])
				board[row, col] := knight_sq
				knight.set_loc(square)

--				board.put ("N", square.integer_item (1), square.integer_item (2))
			end
		end
	set_init_string(str: STRING)
		do
			init_string := str
		end
	add_history(cmd: COMMAND)
		do
			history.force (cmd, history.count + 1)
			j := j + 1
		end
	set_args(with: TUPLE[INTEGER, INTEGER])
		do
			history_args.force (with,history_args.count + 1)
		end
	undo
		do
			if i > 0 then
				if j > 0 and j <= history.count then
					history.at (j).undo (history_args.at (j))
					j := j - 1
					i := i - 1
				end
				init_string := "  ok:"
			else
				error_string := "  no more to undo:"
			end
		end
	redo
		do
			i := i + 1
			if  (j > 0 and j < history.count) or (j ~ 0 and history.count > 0) then
				j := j + 1
				history.at (j).redo (history_args.at (j))
			init_string := "  ok:"
			else
				error_string := "  nothing to redo:"
				i := i - 1
			end
		end
	wipe_hist(start: INTEGER)
		do
			history :=	history.subarray (1, start)
			history_args := history_args.subarray (1, start)
		end

feature -- queries
	out_of_bounds(move_to: TUPLE[INTEGER, INTEGER]): BOOLEAN
		do
			Result := FALSE
			if move_to.integer_item (1) > board.height or move_to.integer_item (1) < 1 then
				Result := TRUE
			elseif move_to.integer_item (2) > board.height or move_to.integer_item (2) < 1 then
				Result := TRUE
			end

		end
	too_many_pieces(move_to: TUPLE[INTEGER, INTEGER]): BOOLEAN
		do
			Result := FALSE
			if king.row ~ move_to.integer_item (1) and king.col ~ move_to.integer_item (2) then
				Result := TRUE
			elseif knight.row ~ move_to.integer_item (1) and knight.col ~ move_to.integer_item (2) then
				Result := TRUE
			end
		end
	in_game: BOOLEAN
		do
			Result := FALSE
			if board.width > 0 then
				Result := TRUE
			end
		end
	board_out: STRING
		local
			row_counter, col_counter: INTEGER
			temp: TUPLE[INTEGER, INTEGER]
		do
			create Result.make_empty
			if board.height > 0 then
				from
					row_counter := 1
				until
					row_counter ~ board.height + 1
				loop

					Result.append ("%N")
					Result.append ("  ")

					from
						col_counter := 1
					until
						col_counter ~ board.width + 1
					loop

						if board[row_counter, col_counter].item ~ "N" then
							if knight.col ~ col_counter and knight.row ~ row_counter then
								Result.append(board[row_counter, col_counter].item)
							else
								Result.append("_")
							end
						elseif board[row_counter, col_counter].item ~ "K" then
							if king.col ~ col_counter and king.row ~ row_counter then
								Result.append(board[row_counter, col_counter].item)
							else
								Result.append("_")
							end
						else
							Result.append(board[row_counter, col_counter].item)
--							Io.putstring (board[row_counter, col_counter].item.out)
						end


--						Result.append (board[row_counter, col_counter].item)
						col_counter := col_counter + 1
					end
					row_counter := row_counter + 1
				end
			end

		end

	out : STRING
		do
			create Result.make_empty
--			Result.append ("King location " + king.row.out + ":" + king.col.out + "%N")
--			Result.append ("Knight location " + knight.row.out + ":" + knight.col.out + "%N")
			Result.append (init_string)
			if in_game and error_string.is_empty then
				Result.append (board_out)
			elseif not error_string.is_empty then
				Result.append (error_string)
			end
--			Result.append ("TESTING: %N")
--			Result.append (board_out)
			init_string.wipe_out
			error_string.wipe_out
		end
end




