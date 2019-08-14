SELECT top 100 a.Billed, a.DispenseDt, a.InvoiceNo, a.FacID,  b.PatLName + ',' + b.PatFName + CASE len(rtrim(COALESCE (b.PatMI, ''))) WHEN 0 THEN '' ELSE ' ' + b.PatMI + '.' END AS PatName, a.RxNo, a.NDC, a.DrugLabelName,  a.Qty,
                                                a.BillAmt, a.invcost, a.billamt-a.invcost as Difference, case when a.invcost <> 0 then (a.billamt-a.invcost)/a.billamt else '0' end as Margin,
                                                a.PatID, a.invoiceGrp,
           
            /* (case when a.BillAmt < 0 then
                  (select top 1 coalesce(salestaxpd, 0) from ECSHistory d where d.HdrStatus = 'A' and d.RecType = 'R' and
                        d.FacID = a.FacID and d.InsID = a.MOP and d.RxNo = a.RxNo and d.DispenseDt = a.DispenseDt and d.PharmID = a.PharmID and d.PatID = a.PatID)
                  else
                        (select top 1 coalesce(salestaxpd, 0) from ECSHistory e where e.HdrStatus = 'A' and e.RspStatus in ('P', 'C') and
                        e.FacID = a.FacID and e.InsID = a.MOP and e.RxNo = a.RxNo and e.DispenseDt = a.DispenseDt and e.PharmID = a.PharmID and e.PatID = a.PatID)
                  end) as SalesTaxPd, */
                                                                  c.InsName, a.PharmID , a.MOP
      from Billing a
      left outer join Patients b on a.FacID = b.FacID and a.PatID = b.PatID
      left outer join InsPlans c on a.MOP = c.InsID   
                  where DispenseDt >= '2019-07-01' and dispensedt < '2019-08-01'
