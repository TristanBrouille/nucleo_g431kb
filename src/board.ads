package Board is
   procedure Setup_Board;
   pragma Export (C, Setup_Board, "_ada_setup_board");
end Board;