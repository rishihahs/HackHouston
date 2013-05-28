USE [HackHou2008]
GO

/****** Object:  StoredProcedure [dbo].[GetJSON]    Script Date: 5/28/2013 4:31:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[GetJSON]
(
@table_name varchar(50),
@department varchar(50) = null,
@registries_per_request smallint = null
)
as
begin
-- 
-- Author:  	Thiago R. Santos										   --
-- Create date: Aug 3rd 2008    										       --
-- Description: Returns the contents of a given table					   --
--  			in JavaScript Object Notation.							   --
-- Params:  															   --
--      @table_name: the table to execute the query						   --
--      @registries_per_request: equivalent to "select top N * from table" 
-- 
--  							 replcing N by the actual number		   
-- Influenced by Thomas Frank's post MySQL to JSON @ January 23, 2007      --
-- Post Url: http://www.thomasfrank.se/mysql_to_json.html  
--
-- Modified by David Young (@deepinthecode http://twitter.com/deepinthecode 
-- http://deepinthecode.com) to allow for a longer JSON return value                --

if((select count(*) from information_schema.tables where table_name =   @table_name)     > 0)
begin
	declare	@json varchar(max),
			@line varchar(max),
			@columns varchar(max),
			@sql nvarchar(max),
			@columnNavigator varchar(50),
			@counter int,
			@size varchar(10),
			@departmentname varchar(50)

	set @departmentname = ''
	if @department IS NOT NULL SET @departmentname = ',"ResponsibleDepartment":"'+convert(varchar,@department)+'"'

	if (@registries_per_request is null) 
	begin
		set @size = ''
	end
	else 
	begin
		set @size = 'top ' + convert(varchar, @registries_per_request)
	end
	set	@columns = '{'

	declare	schemaCursor cursor
	for select column_name from information_schema.columns where table_name = @table_name
	open	schemaCursor	

	fetch next from schemaCursor
	into  @columnNavigator

	select	@counter = count(*) from information_schema.columns where table_name = @table_name

	while @@fetch_status = 0
	begin
		set @columns = @columns + '"' + @columnNavigator + '":"'' + isnull(convert(varchar, [' + @columnNavigator + ']),''N/A'') + ''"'
		set @counter = @counter - 1
		if(0 != @counter) 
		begin
			set @columns = @columns + ','
		end

		fetch next from schemaCursor
		into  @columnNavigator
	end	

	set	@columns =  @columns + @departmentname + '}'

	close		schemaCursor
	deallocate	schemaCursor

	set	@json = '['

	set @sql = 'select  ' + @size + '''' + @columns + ''' as json into tmpJsonTable from ' + @table_name
	--print @sql
	exec sp_sqlexec @sql
	--select * from tmpJsonTable
	select	@counter = count(*) from tmpJsonTable

	declare	tmpCur cursor
	for		select * from tmpJsonTable
	open	tmpCur

	fetch next from tmpCur
	into  @line

	while @@fetch_status = 0
	begin
		set	@counter = @counter - 1
		set @json = @json + @line
		if ( 0 != @counter ) 
		begin
			set @json = @json + ','
		end

		fetch next from tmpCur
		into  @line
	end

	set	@json = @json + ']'

	close		tmpCur
	deallocate	tmpCur
	drop table	tmpJsonTable

	--print len(@json)
	--print right(@json, 10)
	select @json as json
end
end

GO


