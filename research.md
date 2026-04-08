---
layout: page
permalink: /research/
---

{% include image.html url="/images/Norway1.jpg" width=800 align="center" %}

*Research supported in part by NIH R01-HL152439 (2021-2022, 2024), NSF DMS-2113589/2415067 (2021-2025), and NSF DMS-2413294 (2024-2027).*

❈ denotes equal contributions <br>

{% for paper in site.data.papers %}
<div class="paper-entry">
{{ paper.title }} <br>
{{ paper.authors }} ({{ paper.year }}) <br>
*{{ paper.venue }}* <br>
{% for link in paper.links %}[{{ link.label }}]({{ link.url }}){% unless forloop.last %} | {% endunless %}{% endfor %}{% if paper.bibtex %}{% if paper.links %} | {% endif %}<span class="bib-toggle" style="cursor:pointer;color:#6688aa;" data-target="bib-{{ paper.key }}">bibtex</span>{% endif %}
{% if paper.bibtex %}
<div id="bib-{{ paper.key }}" class="bib-content" style="display:none">
<pre>{{ paper.bibtex }}</pre>
</div>
{% endif %}
</div>
{% endfor %}

<script>
document.querySelectorAll('.bib-toggle').forEach(function(el) {
  el.addEventListener('click', function() {
    var target = document.getElementById(this.getAttribute('data-target'));
    target.style.display = target.style.display === 'none' ? 'block' : 'none';
  });
});
</script>
