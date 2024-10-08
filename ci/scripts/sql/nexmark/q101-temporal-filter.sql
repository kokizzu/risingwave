-- noinspection SqlNoDataSourceInspectionForFile
-- noinspection SqlResolveForFile
CREATE SINK nexmark_q101_temporal_filter AS
SELECT
    a.id AS auction_id,
    a.item_name AS auction_item_name,
    b.max_price AS current_highest_bid
FROM auction a
LEFT OUTER JOIN (
    SELECT
        b1.auction,
        MAX(b1.price) max_price
    FROM bid_filtered b1
    GROUP BY b1.auction
) b ON a.id = b.auction
WITH ( connector = 'blackhole', type = 'append-only', force_append_only = 'true');
