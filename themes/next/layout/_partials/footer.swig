<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>

  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
</div>







<!-- 新增访客统计代码 -->

<div class="busuanzi-count">
    <script async="" src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
    <span class="site-uv">
      <i class="fa fa-user"></i>
      访问用户： <span class="busuanzi-value" id="busuanzi_value_site_uv"></span> 人
    </span>
    <div class="powered-by"></div>
    <span class="site-uv">
      <i class="fa fa-eye"></i>
      访问次数： <span class="busuanzi-value" id="busuanzi_value_site_pv"></span> 次
    </span>
    <!-- 博客字数统计 -->
    <span class="site-pv">
      <i class="fa fa-pencil"></i>
      博客全站共： <span class="post-count">{{ totalcount(site) }}</span> 字
    </span>
</div>
<!-- 新增访客统计代码 END-->


{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}
