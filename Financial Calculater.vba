Sub Button1_Click()

Dim c
Dim col
Dim d As String
Dim y As String
Dim fprice As Integer
Dim sprice As Integer
Dim oprice As Integer
Dim dat As Date
Dim m As String
Dim year As String

'find first empty column
Dim finalcolumn As Integer, firstemptycolumn As Integer

' Placeholder for empty cells (see where to start from row 5
firstemptycolumn = Sheet4.Cells(5, Sheet4.Columns.Count).End(xlToLeft).Column 'same as shift method move ur 1 time left:
col = 65
col = col + firstemptycolumn

' Placeholder for today date
m = Format(Date, "mmm")
year = Format(Date, "yyyy")

c = InputBox("Please enter the COLUMN you would like to override", Planner, Chr(col))
d = InputBox("Please enter the MONTH you would like to breakdown", Planner, m)
y = InputBox("Please enter the YEAR you would like to breakdown", Planner, year)
fprice = InputBox("Please enter the amount spent on FOOD in " & d & " " & y, Planner, 0)
sprice = InputBox("Please enter the amount spent on SHOPPING in " & d & " " & y, Planner, 0)
rprice = InputBox("Please enter the amount spent on RS in " & d & " " & y, Planner, 0)
oprice = InputBox("Please enter the amount spent on OTHERS in " & d & " " & y, Planner, 0)

Dim dateArray As Variant, dataArray As Variant
dateArray = Array(d, y)
dataArray = Array(fprice, sprice, rprice, oprice)
Dim i As Integer

'date
For i = 0 To UBound(dateArray, 1)
    Sheet4.Range("" & c & (i + 1)) = dateArray(i)
    'Debug.Print dateArray(i)
Next i

'data
For i = 0 To UBound(dataArray, 1)
    Sheet4.Range("" & c & (i + 5)) = dataArray(i)
    'Debug.Print dataArray(i)
Next i



End Sub


