---
layout: default
title: About
---
#About Placemat

Placemat is a robust (maybe?) pre-processing language exclusively for HTML tables.
The idea is to add functionality not found in standard .md tables. Such as col and row span, and cell classes and ids.

It uses its own format that looks something like this

{% highlight html %}
; This is a table
Customer ID|First Name |Last Name       |email
-------------------------------------------------------------
0001       |Duckworth               ::c2|butler@moneybin.net
0002   ::r2|Scrooge    |McDuck   ::.gold|scrooge@example.com
-       ::X|Scrooge    |McDuck   ::.gold|scrooge@moneybin.net  

{% endhighlight %}

and renders into something like this.

<div class="table_wrap">
<table>
	<tr> <th >Customer ID</th><th >First Name</th><th >Last Name</th><th >email</th> </tr>
	<tr> <td >0001</td><td colspan="2" >Duckworth               </td><td >butler@moneybin.net</td> </tr>
	<tr> <td rowspan="2" >0002   </td><td >Scrooge</td><td class="gold" >McDuck   </td><td >scrooge@example.com</td> </tr>
	<tr> <td >Scrooge</td><td class="gold" >McDuck   </td><td >scrooge@moneybin.net</td> </tr>
</table>

</div>

It can do other stuff too, like inline comments.
