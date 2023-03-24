Option Explicit

Public lastRow As Integer, firstRow As Integer
Public tradingCost As String
Public datecol As Integer, stopLossCol As Integer, takeProfitCol As Integer, entryPriceCol As Integer, shares As Integer, entryPriceColRT As Integer, exitPriceCol As Integer, tradingCostCol As Integer, pnlCol As Integer, riskCol As Integer


Sub Paste()

setRows
setCol

'get value
'Debug.Print Investments.Range("A" & lastRow + 1).Value


ifLastDataExist lastRow, datecol, Date, False
'ifNotExist
setFixedRows
calculateRiskReward
End Sub

'works for last col oni
Function ifLastDataExist(row As Integer, targetCol As Integer, data As String, isFormula As Boolean) 'need to set as dynamic
    
If IsEmpty(Investments.Cells(row, targetCol).Value) Then
    If isFormula = False Then
        Investments.Cells(row, targetCol).Value = data
    Else
        Investments.Cells(row, targetCol).FormulaR1C1 = data
    End If
    
End If

End Function

Function setFixedRows()
Dim formula As String

'formula for d column
ifLastDataExist lastRow, entryPriceColRT, "=RC[-1].Price", True

'copy paste value from col d
ifLastDataExist lastRow, entryPriceCol, Investments.Cells(lastRow, entryPriceColRT).Value, False

'trading cost is set - utilities
ifLastDataExist lastRow, tradingCostCol, tradingCost, False

'if not empty condition =(E10-H10)/GCD((E10-H10),(I10-E10))&":"&(I10-E10)/GCD((E10-H10),(I10-E10))
If Not (IsEmpty(Investments.Cells(lastRow, takeProfitCol))) And Not (IsEmpty(Investments.Cells(lastRow, stopLossCol))) Then
Debug.Print takeProfitCol, stopLossCol

ifLastDataExist lastRow, riskCol, calculateRiskReward, True
End If

'closed position pnl =IF(ISBLANK(J12)," ",(J12-D12)*G12-K12)
If Not (IsEmpty(Investments.Cells(lastRow, exitPriceCol))) And Not (IsEmpty(Investments.Cells(lastRow, shares))) Then
    ifLastDataExist lastRow, pnlCol, "=(RC[-3]-RC[-8])*RC[-6]-RC[-2]", True
    
End If





End Function
Function calculateRiskReward() As String

Dim EntryPrice As Double
Dim stoplossPrice As Double
Dim takeProfitPrice As Double
Dim gcde As Integer
Dim res As String



EntryPrice = Investments.Cells(lastRow, entryPriceCol)
stoplossPrice = Investments.Cells(lastRow, stopLossCol)
takeProfitPrice = Investments.Cells(lastRow, takeProfitCol)
Debug.Print EntryPrice, stoplossPrice, takeProfitPrice
gcde = gcd((takeProfitPrice - EntryPrice), (EntryPrice - stoplossPrice))

'Debug.Print CInt(EntryPrice - stoplossPrice) / gcde, CInt(takeProfitPrice - EntryPrice) / gcde
res = CStr(CInt(EntryPrice - stoplossPrice) / gcde) & " : " & CStr(CInt(takeProfitPrice - EntryPrice) / gcde)

calculateRiskReward = res

End Function


Function gcd(n1 As Double, n2 As Double) As Double


    Dim div     As Double   ' Divsor
    Dim dvd     As Double   ' Divedend
    Dim r       As Double   ' Remainder
    
        ' // Do not divide the numbers if one of them is zero.
        If n1 = 0 Or n2 = 0 Then
            gcd = n1 + n2
            Exit Function
        End If
        
        ' // Assign the dividend and divisor.
        dvd = n1
        div = n2
        
        ' // Swap the numbers if the dividend is smaller than the divsor.
        If n1 < n2 Then
            div = n1
            dvd = n2
        End If
        
        ' // Apply the Euclid's algorthm.
        Do
            r = dvd Mod div
            If r = 0 Then Exit Do
            dvd = div
            div = r
        Loop
        
        gcd = div
        
End Function

