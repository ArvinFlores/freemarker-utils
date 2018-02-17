<#function concat list items...>
  <#local results = [] + list/>

  <#if items?size == 0>
    <#return results>
  </#if>
  
  <#list items as item>
    <#if item?is_sequence>
      <#local results = results + item/>
    <#else>
      <#local results = results + [item]/>
    </#if>
  </#list>

  <#return results>
</#function>

<#function map list transform>
  <#local results = []/>

  <#if list?size == 0>
    <#return results>
  </#if>

  <#list list as item>
    <#local results = results + [transform(item, item?index)]/>
  </#list>

  <#return results>
</#function>

<#function filter list passes>
  <#local results = []/>

  <#if list?size == 0>
    <#return results>
  </#if>

  <#list list as item>
    <#if passes(item, item?index)>
      <#local results = results + [item]/>
    </#if>
  </#list>

  <#return results>
</#function>

<#function find list found>
  <#if list?size == 0>
    <#return -1>
  </#if>

  <#list list as item>
    <#if found(item)>
      <#return item>
    </#if>
  </#list>

  <#return -1>
</#function>

<#function includes list included>
  <#if list?size == 0>
    <#return false>
  </#if>

  <#list list as item>
    <#if included?is_macro>
      <#if included(item)>
        <#return true>
      </#if>
    <#else>
      <#if item == included>
        <#return true>
      </#if>
    </#if>
  </#list>

  <#return false>
</#function>

<#function every list passes>
  <#if list?size == 0>
    <#return true>
  </#if>

  <#list list as item>
    <#if !passes(item)>
      <#return false>
    </#if>
  </#list>

  <#return true>
</#function>

<#function some list passes>
  <#if list?size == 0>
    <#return false>
  </#if>

  <#list list as item>
    <#if passes(item)>
      <#return true>
    </#if>
  </#list>

  <#return false>
</#function>

<#function reduce list fn acc=false>
  <#local len = list?size/>
  <#local startAt = 0/>

  <#if acc?is_boolean>
    <#local accumulator = list[0]!false>
    <#local startAt = 1/>
  <#else>
    <#local accumulator = acc>    
  </#if>
  
  <#if list?size == 0 && accumulator?is_boolean>
    <#stop "Reduce of empty array with no initial value">
  </#if>

  <#if list?size == 0>
    <#return accumulator>
  </#if>

  <#list startAt..(len - 1) as i>
    <#local accumulator = fn(accumulator, list[i], i)/>
  </#list>

  <#return accumulator>
</#function>

<#function slice list limits...>
  <#local len = list?size/>
  <#local from = limits[0]!0/>
  <#local to = limits[1]!list?size/>
  <#local startAt = 0/>
  <#local stopAt = 0/>
  <#local size = 0/>
  <#local results = []/>
  
  <#if from gte 0>
    <#local startAt = from>
  <#else>
    <#if (len + from) lt 0>
      <#local startAt = 0>
    <#else>
      <#local startAt = len + from>
    </#if>
  </#if>

  <#if to lt len>
    <#local stopAt = to>
  <#else>
    <#local stopAt = len>
  </#if>

  <#if to lt 0>
    <#local stopAt = len + to>
  </#if>

  <#local size = stopAt - startAt/>
  
  <#if size gt 0>
    <#list 0..(size - 1) as i>
      <#local results = results + [list[startAt + i]]/>
    </#list>

    <#return results>
  </#if>

  <#return results>
</#function>