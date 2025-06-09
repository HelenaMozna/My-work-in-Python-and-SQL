-- Vypiš názvy produktů a počet jejich prodaných kusů.

SELECT
    p.product,
    sum(s.units) as total_untis
FROM
    sales s
    join product p on p.ProductID = s.ProductID
group BY
    p.Product
order BY
    -- total_untis DESC

--  2. Zobraz názvy produktů a země, ve kterých se prodaly.
 SELECT
    p.product,
    c.state
    
FROM
    sales s
    join product p on p.ProductID = s.ProductID
    join country c on s.zip = c.zip
group BY
    p.product,
    c.state

--      3. Který výrobce prodal nejvíce kusů?
 SELECT top 1 with ties
    m. manufacturer,
    sum(s.units) as total_units
FROM
    sales s
    join product p on p.ProductID = s.ProductID
    join manufacturer m on m.ManufacturerID = p.ManufacturerID
group BY
    m.manufacturer
order BY
    total_units desc

-- Zobraz názvy výrobků, jejich výrobce a celkové tržby z prodeje (množství * cena).
SELECT
    p.product,
    m.manufacturer,
    sum(Revenue) as total_revenue
FROM
    sales s
    join product p on p.ProductID = s.ProductID
    join manufacturer m on m.ManufacturerID = p.ManufacturerID
group BY
    p.Product,
    m.manufacturer

-- Pojďme dál – dáme těch top 5 zemí podle tržeb?
 SELECT top 5
    c.state,
    SUM(Revenue) AS Total_revenue
FROM
    sales s
    join country c on s.zip = c.zip
group BY
    C.[State]   
Order BY
    Total_revenue desc

-- Zobraz všechny produkty a k nim přiřaď počet prodaných jednotek, i když se některé produkty ještě nikdy neprodaly.
SELECT
    p.product,
    sum(Units) as Total_units
FROM
    product p
    left join sales s on p.productID = s.ProductID
group BY
    p.product
order BY
    Total_units DESC