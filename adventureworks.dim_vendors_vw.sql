# products from CSV
# purchase orders from MongoDB
# vendors from mysql

CREATE OR REPLACE VIEW dim_products_vw AS
(
	WITH ProductCatsAndSubCatsCTE AS 
	(
		SELECT pc.ProductCategoryID
			, pc.Name AS ProductCategory
			, psc.ProductSubcategoryID
			, psc.Name AS ProductSubcategory
		FROM productcategory AS pc
		INNER JOIN productsubcategory AS psc
		ON pc.ProductCategoryID = psc.ProductCategoryID
	)
	SELECT p.ProductID,
		p.Name,
		p.ProductNumber,
		p.MakeFlag,
		p.FinishedGoodsFlag,
		p.Color,
		p.SafetyStockLevel,
		p.ReorderPoint,
		p.StandardCost,
		p.ListPrice,
		p.Size,
		p.SizeUnitMeasureCode,
		p.WeightUnitMeasureCode,
		p.Weight,
		p.DaysToManufacture,
		p.ProductLine,
		p.Class,
		p.Style,
		psc.ProductCategory,
		psc.ProductSubcategory,
		pm.NAME AS ProductModel,
		p.SellStartDate,
		p.SellEndDate,
		p.DiscontinuedDate
	FROM product AS p
	LEFT OUTER JOIN ProductCatsAndSubCatsCTE AS psc
	ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	LEFT OUTER JOIN productmodel AS pm
	ON p.ProductModelID = pm.ProductModelID
);

SELECT * FROM dim_products_vw;
SELECT COUNT(*) FROM dim_products_vw;

-- ----------------------------------------------------------------------------------
-- Get Vendor Data -----------------------------------------------------------------
-- ----------------------------------------------------------------------------------
#mysql
CREATE OR REPLACE VIEW dim_vendors_vw AS
(
	SELECT v.VendorID
		, v.AccountNumber
		, v.Name
		, v.CreditRating
		, v.PreferredVendorStatus
		, v.ActiveFlag
		, t.Name AS AddressType
		, a.AddressLine1
		, a.AddressLine2
		, a.City
		, sp.StateProvinceCode
		, sp.Name AS `State_Province`
		, a.PostalCode
	FROM vendor AS v
	INNER JOIN vendoraddress AS va
	ON v.VendorID = va.VendorID
	INNER JOIN address AS a
	ON va.AddressID = a.AddressID
	INNER JOIN stateprovince AS sp
	ON sp.StateProvinceID = a.StateProvinceID
	INNER JOIN addresstype AS t
	ON va.AddressTypeID = t.AddressTypeID
);

SELECT * FROM dim_vendors_vw;

-- ----------------------------------------------------------------------------------
-- Get Purchase Order Data ----------------------------------------------------------
-- ----------------------------------------------------------------------------------
#json file - MongoDB
CREATE OR REPLACE VIEW fact_purchase_orders_vw AS
(
	SELECT poh.PurchaseOrderID
		, poh.RevisionNumber
		, poh.Status
		, poh.EmployeeID
		, poh.VendorID
		, pod.ProductID
		, pod.OrderQty
		, pod.UnitPrice
		, pod.LineTotal
		, poh.OrderDate
		, sm.Name AS ShipMethod
		, sm.ShipBase
		, sm.ShipRate
		, poh.ShipDate
		, poh.SubTotal
		, poh.TaxAmt
		, poh.Freight
		, poh.TotalDue
		, pod.DueDate
		, pod.ReceivedQty
		, pod.RejectedQty
		, pod.StockedQty
	FROM purchaseorderheader AS poh
	INNER JOIN shipmethod AS sm
	ON poh.ShipMethodID = sm.ShipMethodID
	LEFT OUTER JOIN purchaseorderdetail AS pod
	ON poh.PurchaseOrderID = pod.PurchaseOrderID
);
SELECT * FROM fact_purchase_orders_vw;