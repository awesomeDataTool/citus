create table namenest1 (id integer primary key, user_id integer);
create table namenest2 (id integer primary key, value_2 integer);
select * from create_distributed_table('namenest1', 'id');
select * from create_reference_table('namenest2');

SELECT r
FROM (
	SELECT user_id_deep, random() as r -- prevent pulling up the subquery
	FROM (
		namenest1
		JOIN namenest2 ON (namenest1.user_id = namenest2.value_2)
	) AS join_alias(user_id_deep)
) AS bar, (
	namenest1
	JOIN namenest2 ON (namenest1.user_id = namenest2.value_2)
) AS join_alias(user_id_deep)
WHERE (bar.user_id_deep = join_alias.user_id_deep);

drop table namenest1;
drop table namenest2;