CREATE DATABASE insaurance_fraud;
USE insaurance_fraud;

SELECT * FROM Insaurance_claims LIMIT 5;

USE insaurance_fraud;

SELECT 
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_claims,
    ROUND(
        100 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM Insaurance_claims;

SELECT 
    incident_type,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
    ROUND(
        100 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM Insaurance_claims
GROUP BY incident_type
ORDER BY fraud_rate_percent DESC;

SELECT 
    incident_state,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
    ROUND(
        100 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM Insaurance_claims
GROUP BY incident_state
ORDER BY fraud_rate_percent DESC;

SELECT 
    fraud_reported,
    ROUND(AVG(total_claim_amount),2) AS avg_claim_amount
FROM Insaurance_claims
GROUP BY fraud_reported;


SELECT 
    police_report_available,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
    ROUND(
        100 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM Insaurance_claims
GROUP BY police_report_available
ORDER BY fraud_rate_percent DESC;

SELECT 
    insured_occupation,
    COUNT(*) AS fraud_cases
FROM Insaurance_claims
WHERE fraud_reported = 'Y'
GROUP BY insured_occupation
ORDER BY fraud_cases DESC
LIMIT 10;

SELECT 
    policy_number,
    total_claim_amount,
    incident_type,
    incident_state
FROM Insaurance_claims
WHERE fraud_reported = 'Y'
ORDER BY total_claim_amount DESC
LIMIT 10;

SELECT
    CASE
        WHEN age <= 25 THEN '18-25'
        WHEN age <= 35 THEN '26-35'
        WHEN age <= 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
    ROUND(
        100 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM Insaurance_claims
GROUP BY age_group
ORDER BY fraud_rate_percent DESC;

SELECT incident_date
FROM Insaurance_claims
LIMIT 5;

SELECT 
    MONTH(STR_TO_DATE(incident_date, '%m/%d/%Y')) AS claim_month,
    COUNT(*) AS total_claims
FROM Insaurance_claims
GROUP BY claim_month
ORDER BY claim_month;

SELECT 
    SUM(total_claim_amount) AS total_fraud_amount
FROM Insaurance_claims
WHERE fraud_reported = 'Y';

