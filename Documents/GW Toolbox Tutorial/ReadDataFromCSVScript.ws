(ATCScript "txtScriptDesc"  (LineEnd CR)  (NextLine 1)  (ColumnFormat ,/                4:Value                3:Year                1:Month                2:Day)  (Set Hour "0")  (Set Minute "0")  (Attribute Scenario "Observed")  (Attribute Location "Test River")  (Attribute Constituent "Streamflow")  (While (Not EOF)         (Date Year               Month               Day               "0"               "0")         (Value Value)         (NextLine)  ))