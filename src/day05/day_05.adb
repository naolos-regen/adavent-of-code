with Ada.Text_IO;	use Ada.Text_IO;

package body Day_05 is


	procedure Solve(File_Path: String) is
		File	: File_Type;
	begin
		Open	(File => File, Mode => In_File, Name => File_Path);
		
		while not End_Of_File (File) loop
			declare
				Line : constant String := Get_Line(File);
			begin
				Put_Line(Line);
			end;
		end loop;

		Close (File);
	end Solve;
end Day_05;
