Attribute VB_Name = "Module1"
Sub Stock_market()

Dim ws As Worksheet

For Each ws In Worksheets

ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"

ws.Range("P1").Value = "Ticker"
ws.Range("Q1").Value = "Value"
ws.Range("O2").Value = "Greatest % Increase"
ws.Range("O3").Value = "Greatest % Decrease"
ws.Range("O4").Value = "Greatest Total Volume"
'Declaring the variables
Dim ticker_row As Integer
ticker_row = 2
Total = 0
Dim i As Long
Dim close_price As Double
close_price = 0
Dim Yearly_price As Double
Yearly_price = 0
Dim open_price As Double
Dim Percent_change As Double
Percent_change = 0

Dim Lastrow As Long
open_price = ws.Cells(2, 3).Value
'Declaring the last row
Lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

 For i = 2 To Lastrow
   
   If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        Total = Total + ws.Cells(i, 7).Value
        'finding the ticker symbol
        ws.Range("I" & ticker_row).Value = ws.Cells(i, 1).Value
        ws.Range("L" & ticker_row).Value = Total
        
        'Yearly_change of the stocks
        close_price = ws.Cells(i, 6).Value
        Yearly_change = close_price - open_price
        ws.Range("J" & ticker_row).Value = Yearly_change
        'finding percent change of the stocks
         Percent_change = (Yearly_change / open_price)
         ws.Range("K" & ticker_row).Value = Percent_change
         ws.Range("K" & ticker_row).Value = Format(ws.Range("K" & ticker_row).Value, "0.00%")
         'Using Conditional formatting that will highlight positive change in green and Negative change in red
           If ws.Range("J" & ticker_row).Value <= 0 Then
                   ws.Range("J" & ticker_row).Interior.Color = vbRed
           Else: ws.Range("J" & ticker_row).Interior.Color = vbGreen
           End If
       'reseting the values to zero
         
        ticker_row = ticker_row + 1
        Total = 0
        open_price = 0
        close_price = 0
        Yearly_price = 0
        Percent_change = 0
        open_price = ws.Cells(i + 1, 3).Value
    
   Else
   Total = Total + ws.Cells(i, 7).Value
   End If
   
    
  
   
   
   
   Next i
   
   
       'calculate the Greatest %Increase
  
  Maxpercent = WorksheetFunction.Max(ws.Range("K2:K" & ticker_row))
  Maxticker = WorksheetFunction.Index(ws.Range("I2:I" & ticker_row), WorksheetFunction.Match(Maxpercent, ws.Range("K2:K" & ticker_row), 0))
  ws.Range("Q2").Value = Maxpercent
  ws.Range("Q2").NumberFormat = "0.00%"
  ws.Range("P2").Value = Maxticker
   
   
       'calculating the Greatest Decrease
  Minpercent = WorksheetFunction.Min(ws.Range("K2:K" & ticker_row))
  Minticker = WorksheetFunction.Index(ws.Range("I2:I" & ticker_row), WorksheetFunction.Match(Minpercent, ws.Range("K2:K" & ticker_row), 0))
  ws.Range("Q3").Value = Minpercent
  ws.Range("Q3").NumberFormat = "0.00%"
  ws.Range("P3").Value = Minticker
        
        
        
   
   'calculating the Greatest total volume
   
   Maxtotal = WorksheetFunction.Max(ws.Range("L2:L" & ticker_row))
   ws.Range("Q4").Value = Maxtotal
   Maxtotalticker = WorksheetFunction.Index(ws.Range("I2:I" & ticker_row), WorksheetFunction.Match(Maxtotal, ws.Range("L2:L" & ticker_row), 0))
   ws.Range("P4").Value = Maxtotalticker
  

Next ws

End Sub




