with Ada.Text_IO;	use Ada.Text_IO;
with Ascii_Art;
with Day_01;
with Day_02;
with Day_03;
with Day_04;
with Day_05;

package body Solutions_Each is

	ESC	: constant Character := Character'Val(27);

	Red		: constant String		:= ESC & "[31m";
	Green		: constant String		:= ESC & "[32m";
	Yellow	: constant String		:= ESC & "[33m";
	Blue		: constant String		:= ESC & "[34m";
	Magenta	: constant String		:= ESC & "[35m";
	Cyan		: constant String		:= ESC & "[36m";
	Reset		: constant String		:= ESC & "[0m";
	
	procedure Year_Two_Three is
	begin
		Ascii_Art.Put_Ascii_Art;
		Put_Line(Blue		& "2023" & Reset);
		Put_Line(Green		& "/Day01" & Reset);
		Day_01.Solve("tasks/2023/DAY01/input.txt");
		Put_Line(Yellow	& "/Day02" & Reset);
		Day_02.Solve("tasks/2023/DAY02/input.txt");
		Put_Line(Cyan		& "/Day03" & Reset);
		Day_03.Solve("tasks/2023/DAY03/input.txt");
		Put_Line(Red		& "/Day04" & Reset);
		Day_04.Solve("tasks/2023/DAY04/input.txt");
		Put_Line(Magenta	& "/Day05" & Reset);
		Day_05.Solve("tasks/2023/DAY05/test.txt");
	end Year_Two_Three;
end Solutions_Each;
