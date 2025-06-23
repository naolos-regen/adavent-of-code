with Reading_File;
with Ada.Text_IO; 		use Ada.Text_IO;
with Ada.Strings.Unbounded; 	use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;
with Ada.Containers.Vectors;

package body Reading_File is
	
	package Integer_Vectors is new Ada.Containers.Vectors
		(Index_Type => Positive,
		 Element_Type => Integer);
	use Integer_Vectors;
	
	type Digit_Name is (One, Two, Three, Four, Five, Six, Seven, Eight, Nine);
	
	subtype Digit_Char is Character range '0' .. '9';
	Digit_Strings: constant array(Digit_Name) of String_Access := (
		new String'("one"),
		new String'("two"),
		new String'("three"),
		new String'("four"),
		new String'("five"),
		new String'("six"),
		new String'("seven"),
		new String'("eight"),
		new String'("nine")
	);
        Digit_Values: constant array(Digit_Name) of Integer := (1, 2, 3, 4, 5, 6, 7, 8, 9);

	function Get_Result_From_Line_Part_One(Line : String) return Vector is
		First_Digit 	: Integer 	:= 0;
		Last_Digit  	: Integer 	:= 0;
		First_Found 	: Boolean 	:= False;
		Result 		: Vector 	:= Empty_Vector;
	begin
		for Char of Line loop
			if Char >= '0' and then Char <= '9' then
				declare
					Digit: Integer := Character'Pos(Char) - Character'Pos('0');
				begin
					if not First_Found then
						First_Digit := Digit;
						First_Found := True;
					end if;
					Last_Digit := Digit;
				end;
			end if;
		end loop;
		if First_Found then
			Result.Append(First_Digit * 10);
			Result.Append(Last_Digit);
		end if;
		return Result;
	end Get_Result_From_Line_Part_One;

	function Get_Result_From_Line_Part_Two(Line : Unbounded_String) return Vector is 
		First_Digit : Integer := 0;
		Last_Digit  : Integer := 0;
		First_Found : Boolean := False;
		Result : Vector := Empty_Vector;
		Raw : constant String := To_String(Line);
		Index : Positive := Raw'First;
		begin
			while Index <= Raw'Last loop
				declare
					Digit: Integer := -1;
				begin
					if Raw(Index) in '0' .. '9' then
						Digit := Character'Pos(Raw(Index)) - Character'Pos('0');
						Index := Index + 1;
					else
						for D in Digit_Name loop
							declare
								Name : constant String := Digit_Strings(D).all;
								Len  : constant Natural := Name'Length;
							begin
								if Index + Len - 1 <= Raw'Last then
									if Raw(Index .. Index + Len - 1) = Name then
										Digit := Digit_Values(D);
										Index := Index + Len;
										exit;
									end if;
								end if;
							end;
						end loop;
						if Digit = -1 then
							Index := Index + 1;
						end if;
					end if;
					
					if Digit /= -1 then
						if not First_Found then
							First_Digit := Digit;
							First_Found := True;
						end if;
						Last_Digit := Digit;
					end if;
				end;
			end loop;

			if First_Found then
				Result.Append(First_Digit * 10);
				Result.Append(Last_Digit);
			end if;
				
			return Result;
	end Get_Result_From_Line_Part_Two;

	procedure Read_File(File_Path : String) is
		use Ada.Text_IO.Unbounded_IO;
		File			: File_Type;
		Line			: Unbounded_String;
		Result_Part_One		: Vector 		:= Empty_Vector;
		Result_Part_Two		: Vector 		:= Empty_Vector;
		Sum			: Integer		:= 0;
		Line_Result_Part_One 	: Vector;
		Line_Result_Part_Two 	: Vector;
	begin
		Open   (File => File, 
			Mode => In_File, 
			Name => File_Path);
	
		while not End_Of_File (File) loop
			Line := Get_Line(File);
			Line_Result_Part_One := Get_Result_From_Line_Part_One (To_String (Line));
			Line_Result_Part_Two := Get_Result_From_Line_Part_Two (Line);

			for Item of Line_Result_Part_One loop
				Result_Part_One.Append(Item);
			end loop;
			for Item of Line_Result_Part_Two loop
				Result_Part_Two.Append(Item);
			end loop;

		end loop;
	
		Close(File);

		for Val of Result_Part_One loop
			Sum := Sum + Val;
		end loop;
		Put_Line("Part 1: " & Integer'Image(Sum));
		Sum := 0;
		for Val of Result_Part_Two loop
			Sum := Sum + Val;
		end loop;
		Put_Line("Part 2: " & Integer'Image(Sum));
	end Read_File;


end Reading_File;
