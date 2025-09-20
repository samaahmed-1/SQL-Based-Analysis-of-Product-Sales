SELECT name, type
FROM sqlite_master
WHERE type IN ('table','view')
ORDER BY name;

SELECT * FROM Invoice LIMIT 5;
SELECT * FROM Track LIMIT 5;
SELECT * FROM InvoiceLine LIMIT 5;

SELECT
  t.TrackId,
  t.Name AS TrackName,
  ar.Name AS ArtistName,
  a.Title AS AlbumTitle,
  SUM(il.UnitPrice * il.Quantity) AS Revenue,
  SUM(il.Quantity) AS QuantitySold
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist ar ON a.ArtistId = ar.ArtistId
GROUP BY t.TrackId, t.Name, ar.Name, a.Title
ORDER BY Revenue DESC
LIMIT 10;

SELECT
  t.TrackId,
  t.Name AS TrackName,
  SUM(il.Quantity) AS QuantitySold,
  SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY QuantitySold DESC
LIMIT 10;

SELECT
  BillingCountry,
  COUNT(DISTINCT InvoiceId) AS InvoiceCount,
  SUM(Total) AS Revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;

SELECT
  strftime('%Y-%m', InvoiceDate) AS YearMonth,
  COUNT(DISTINCT InvoiceId) AS InvoiceCount,
  SUM(Total) AS Revenue
FROM Invoice
GROUP BY YearMonth
ORDER BY YearMonth;

SELECT
  strftime('%Y-%m', i.InvoiceDate) AS YearMonth,
  i.BillingCountry,
  SUM(i.Total) AS Revenue
FROM Invoice i
GROUP BY YearMonth, i.BillingCountry
ORDER BY YearMonth, Revenue DESC;

SELECT
    g.Name AS GenreName,
    SUM(il.Quantity) AS QuantitySold,
    SUM(il.Quantity * il.UnitPrice) AS Revenue,
    RANK() OVER (ORDER BY SUM(il.Quantity * il.UnitPrice) DESC) AS GenreRank
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY GenreRank;


SELECT
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS CustomerName,
  c.Country,
  COUNT(DISTINCT i.InvoiceId) AS InvoiceCount,
  SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
ORDER BY TotalSpent DESC
LIMIT 10;




