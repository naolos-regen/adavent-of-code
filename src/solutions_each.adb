with Ada.Text_IO;	use Ada.Text_IO;
with Day_01;
with Day_02;
with Day_03;
with Day_04;
with Day_04_P_2;

package body Solutions_Each is
	procedure Year_Two_Three is
	begin
		Put_Line("Day 01");
		Day_01.Solve("tasks/2023/DAY01/input.txt");
		Put_Line("Day 02");
		Day_02.Solve("tasks/2023/DAY02/input.txt");
		Put_Line("Day 03");
		Day_03.Solve("tasks/2023/DAY03/input.txt");
		Put_Line("Day 04");
		Day_04.Solve("tasks/2023/DAY04/input.txt");
		Day_04_P_2.Solve("tasks/2023/DAY04/input.txt");
	end Year_Two_Three;
end Solutions_Each;
