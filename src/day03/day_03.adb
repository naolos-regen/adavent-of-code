with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;


package body Day_03 is

	package Unbounded_String_Vectors is new Ada.Containers.Vectors
		(Index_Type	=> Positive,
		 Element_Type	=> Unbounded_String);
	use Unbounded_String_Vectors;

	procedure Solve(File_Path: String) is
		File	: File_Type;
		Line	: Unbounded_String;
	begin
		Open (File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Engine	: constant String := Get_Line(File);
			begin
				Line := To_Unbounded_String(Engine);
			end;
		end loop;

		Close (File);
	end Solve;
end Day_03;
