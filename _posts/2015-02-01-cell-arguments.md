---
layout: default
title:  "Cell Arguments"
date:   2015-02-01 11:31:01
categories: docs
subs:
  - "Ignored Cells"
  - "Colspan and Rowspan"
  - "Classes and Ids"
---

# Cell Arguments

Each cell can take a number of arguments as well. An argument block in Placemat begins with a double colon (**::**), multiple arguments are separated with an ampersand (**&**).

<h2 id="ignored_cells">Ignored Cells</h2>

*X*

The X argument denotes a cell that should not render, this is used primarily for formatting and will be more useful when colspan and rowspan are incorporated

{% highlight html %}
A|B|C
-----
1|this cell wont show ::X|2|3

{% endhighlight %}

<div class="table_wrap">
<table>
	<tr> <th >A</th><th >B</th><th >C</th> </tr>
	<tr> <td >1</td><td >2</td><td >3</td> </tr>
</table>
</div>

<h2 id="colspan_and_rowspan">Colspan and Rowspan</h2>

*c[int] and r[int]*

The c and r arguments are used to specify colspan and rowspan respectively. For these, each is followed by an integer that indicates the value. If no intereger is given the value defaults to one (1).

{% highlight html %}
|Name   ::c2
ID  |First |Last
-----
001 |Scrooge|McDuck
002 |Huey   |Duck ::r3
003 |Dewey  |     ::X
004 |Louie  |     ::X

{% endhighlight %}

<div class="table_wrap">
<table>
	<tr> <th ></th><th colspan="2" >Name   </th> </tr>
	<tr> <th >ID</th><th >First</th><th >Last</th> </tr>
	<tr> <td >001</td><td >Scrooge</td><td >McDuck</td> </tr>
	<tr> <td >002</td><td >Huey</td><td rowspan="3" >Duck </td> </tr>
	<tr> <td >003</td><td >Dewey</td> </tr>
	<tr> <td >004</td><td >Louie</td> </tr>
</table>
</div>

<h2 id="classes_and_ids">Classes and Ids</h2>

*Classes and Ids*

An argument may also be given in the block for a cell to give it
class attributes or an id. This is presented similar to a css selector.
So a cell like

{% highlight html %}
Hello ::.blue.underline#name_columns
{% endhighlight %}

would compile to  
{% highlight html %}
<td class="blue underline " id="name_columns">Hello</td>
{% endhighlight %}

A more robust table may look like:

{% highlight html %}
|Name   ::c2&.blue.underline#name_columns
ID  |First |Last
-----
001 |Scrooge|McDuck ::.gold
002 |Huey   |Duck ::r3&#singleId
003 |Dewey  |     ::X
004 |Louie  |     ::X
{% endhighlight %}

and compile to

{% highlight html %}
<table>
	<tr> <th ></th><th colspan="2" class="blue underline" id="name_columns" >Name   </th> </tr>
	<tr> <th >ID</th><th >First</th><th >Last</th> </tr>
	<tr> <td >001</td><td >Scrooge</td><td class="gold" >McDuck </td> </tr>
	<tr> <td >002</td><td >Huey</td><td rowspan="3" id="singleId" >Duck </td> </tr>
	<tr> <td >003</td><td >Dewey</td> </tr>
	<tr> <td >004</td><td >Louie</td> </tr>
</table>
{% endhighlight %}

<div class="table_wrap">
<table>
	<tr> <th ></th><th colspan="2" class="blue underline" id="name_columns" >Name   </th> </tr>
	<tr> <th >ID</th><th >First</th><th >Last</th> </tr>
	<tr> <td >001</td><td >Scrooge</td><td class="gold" >McDuck </td> </tr>
	<tr> <td >002</td><td >Huey</td><td rowspan="3" id="singleId" >Duck </td> </tr>
	<tr> <td >003</td><td >Dewey</td> </tr>
	<tr> <td >004</td><td >Louie</td> </tr>
</table>
</div>
