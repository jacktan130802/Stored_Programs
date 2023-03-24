Function setRows()
firstRow = 9
lastRow = Investments.Range("c1").End(xlDown).End(xlDown).End(xlDown).row

tradingCost = 0.75

End Function

Function setCol()
datecol = Investments.Range("A7:O7").Find("Date").Column
entryPriceCol = Investments.Range("A7:o7").Find("Entry Price").Column
entryPriceColRT = Investments.Range("A7:o7").Find("Entry RT").Column
tradingCostCol = Investments.Range("A7:o7").Find("Trade Costs").Column
riskCol = Investments.Range("A7:O7").Find("% Of Account Risked").Column
pnlCol = Investments.Range("A7:O7").Find("Closed Position P/L").Column
exitPriceCol = Investments.Range("A7:O7").Find("Actual Exit Price").Column
shares = Investments.Range("A7:O7").Find("No. of Shares").Column
takeProfitCol = Investments.Range("A7:O7").Find("Take Profit Price").Column
stopLossCol = Investments.Range("A7:O7").Find("Stop Loss Price").Column

End Function

