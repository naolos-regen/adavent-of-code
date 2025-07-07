with Ada.Text_IO;		use Ada.Text_IO;

package body Day_03 is

	subtype Index is Integer range 1 .. 140;
	
	type Char_Type is (Empty, Number, Adjacent);

	type Data is record
		Char		: Character := '.'; -- default for this case is '.'
		Typ		: Char_Type := Empty;
		Part_One	: Boolean	:= False;
	end record;
	
	type Integer_Array is array (1 .. 8) of Integer;
	type Array_Of_Chars is array (Index, Index) of Data;

	function Has_Adjacent_Near(Arr: Array_Of_Chars; Row, Start_Col, End_Col : Index) return Boolean is
	begin
		for R in Index'Max(Row - 1, Arr'First(2)) .. Index'Min(Row + 1, Arr'Last(2)) loop
			for C in Index'Max(Start_Col - 1, Arr'First(1)) .. Index'Min(End_Col + 1, Arr'Last(1)) loop
				if Arr(C, R).Typ = Adjacent then
					return True;
				end if;
			end loop;
		end loop;
		return False;
	end Has_Adjacent_Near;

	procedure Lookout(Arr: in out Array_Of_Chars) is 
		J	: Integer;
	begin
		for Row in Arr'Range(2) loop
			J := Arr'First(1);
			while J <= Arr'Last loop
				if Arr(J, Row).Typ = Number then
					declare
						Start_Col	: constant Integer := J;
						End_Col		: Integer := J;
						Str			: String(1..3) := (others => ' ');
						Len			: Integer := 0;
					begin
						while End_Col <= Arr'Last(1) and then Arr(End_Col, Row).Typ = Number loop
							Len := Len + 1;
							if Len <= 3 then
								Str(Len) := Arr(End_Col, Row).Char;
							end if;
							End_Col := End_Col + 1;
						end loop;
						End_Col := End_Col - 1;

						if Has_Adjacent_Near(Arr, Row, Start_Col, End_Col) then
							for K in Start_Col .. End_Col loop
								Arr(K, Row).Part_One := True;
							end loop;
						end if;
						J := End_Col + 1;
					end;
				else
					J := J + 1;
				end if;
			end loop;
		end loop;
	end Lookout;

	-- Lookout for adjacent to a symbol is every possibility of +1 0 -1 arranged in 2 options
	procedure Append(Arr: in out Array_Of_Chars; Line : String; I: Integer) is
		Idx : constant Index 	:= Index(I);
	begin
		for J in Arr'Range (1) loop
			Arr(J, Idx).Char := Line(J);
			if Line(J) in '0' .. '9' then
				Arr(J, Idx).Typ := Number;
			elsif Line(J) /= '.' then
				Arr(J, Idx).Typ := Adjacent;
			end if;
		end loop;
	end Append;

	function Sum_Part_Numbers(Arr: Array_Of_Chars) return Integer is
		Sum : Integer := 0;
		J	 : Integer ;
	begin
		for Row in Arr'Range(2) loop
			J := Arr'First(1);
			while J <= Arr'Last(1) loop
				if Arr(J, Row).Part_One and then Arr(J, Row).Typ = Number then
					declare
						N : Integer := 0;
					begin
						while J <= Arr'Last(1) and then Arr(J, Row).Part_One and then Arr(J, Row).Typ = Number loop
							N := N * 10 + Character'Pos(Arr(J, Row).Char) - Character'Pos('0');
							J := J + 1;
						end loop;
						Sum := Sum + N;
					end;
				else
					J := J + 1;
				end if;
			end loop;
		end loop;
		return Sum;
	end Sum_Part_Numbers;

	function Get_Adjacent_Numbers(Arr: Array_Of_Chars; Col, Row: Index) return Integer_Array is
		Found	: Integer_Array := (others => 0);
		Count	: Integer := 0;
	begin
		for R in Index'Max(Row - 1, Arr'First(2)) .. Index'Min(Row + 1, Arr'Last(2)) loop
			for C in Index'Max(Col - 1, Arr'First(1)) .. Index'Min(Col + 1, Arr'Last(1)) loop
				if Arr(C, R).Typ = Number then
					declare
						Start_C	: Integer := C;
						End_C		: Integer := C;
						Value		: Integer := 0;
					begin
						while Start_C > Arr'First(1) and then Arr(Start_C - 1, R).Typ = Number loop
							Start_C := Start_C - 1;
						end loop;
						while End_C < Arr'Last(1) and then Arr(End_C + 1, R).Typ = Number loop
							End_C := End_C + 1;
						end loop;

						if not (C > Start_C and C < End_C) then
							for I in 1 .. Count loop
								if Found(I) = Start_C * 1000 + R then
									goto Skip;
								end if;
							end loop;

							for I in Start_C .. End_C loop
								Value := Value * 10 + Character'Pos(Arr(I, R).Char) - Character'Pos('0');
							end loop;

							Count := Count + 1;
							if Count <= 8 then
								Found(Count) := Value;
							end if;
						end if;
						<<Skip>>
					end;
				end if;
			end loop;
		end loop;
		return Found;
	end Get_Adjacent_Numbers;

	function Sum_Part_Two(Arr: Array_Of_Chars) return Integer is
		Sum : Integer := 0;
		Adjacent_Nums : Integer_Array;
	begin
		for Row in Arr'Range(2) loop
			for Col in Arr'Range(1) loop
				if Arr(Col, Row).Char = '*' then
					Adjacent_Nums := Get_Adjacent_Numbers(Arr, Col, Row);
					declare
						Count : Integer := 0;
						First, Second : Integer := 0;
					begin
						for I in Adjacent_Nums'Range loop
							if Adjacent_Nums(I) /= 0 then
								Count := Count + 1;
								if Count = 1 then
									First := Adjacent_Nums(I);
								elsif Count = 2 then
									Second := Adjacent_Nums(I);
								end if;
							end if;
						end loop;

						if Count = 2 then
							Sum := Sum + First * Second;
						end if;
					end;
				end if;
			end loop;
		end loop;
		return Sum;
	end Sum_Part_Two;

	procedure Solve(File_Path: String) is
		File	: File_Type;
		Arr	: Array_Of_Chars;
		Index : Natural := 1;
	begin
		Open (File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Engine	: constant String := Get_Line(File);
			begin
				Append(Arr, Engine, Index);
				Index := Index + 1;
			end;
		end loop;
		Lookout(Arr);
		Put_Line("Part 1: " & Integer'Image(Sum_Part_Numbers(Arr)));
		Put_Line("Part 2: " & Integer'Image(Sum_Part_Two(Arr)));
		Close (File);
	end Solve;
end Day_03;
