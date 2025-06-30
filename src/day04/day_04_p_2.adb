package body Day_04_P_2 is

	type Left_Array is array (Positive range <>) of Integer;
	type Right_Array is array (Positive range <>) of Integer;

	type Card_Type is record
		Left_Numbers	: Left_Array;
		Right_Numbers	: Right_Array;
		Matches			: Integer := 0;
	end record;

	type Cards_Array is array (Positive range <>) of Card_Type;


	procedure Solve(File_Path : String) is
		File : File_Type;
		Line : String (1 .. 200);
		Last : Integer;
		Cards	: Cards_Array (Positive range <>);
	begin
		Open(File, In_File, File_Path);
		-- TODO: Learn how to deal with unbounded Array :-)
		Close(File);
	end Solve_Part_Two;

end Day_04_P_2;
