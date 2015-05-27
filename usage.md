---
layout: default
title: Usage
---
# Usage

## Placemat Documents

### File Types
Placemat is an evolving file format. In the current build it is able to handle a small subset of commands. Placemat takes in <strong>.plmat</strong> files and outputs .html

## Running Placemat
Placemat runs from the terminal after installation, by simply pointing to a .plmat file. It will render an html version of that file in the working directory. the <span class="highlight">-c</span> argument passes the file name to render.

So given the directory structure

{% highlight html %}
dir/
   / myfile.plmat
{% endhighlight %}

you could run placemat to compile your file with the following terminal commands.

{% highlight Bash shell scripts %}
cd dir
placemat -c myfile.plmat
{% endhighlight %}

This would yield


{% highlight html %}
dir/
   / myfile.plmat
   / myfile.html
{% endhighlight %}
