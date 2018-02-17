# Java Freemarker Helper Methods

I started this project after noticing some of the limitations of freemarker built-ins for data structures like sequences. The current methods in `sequence.ftl` are inspired by those found on `Array.prototype` in JavaScript. Feel free to contribute to the project in any way you see fit.

# Sequence

## concat
```
<#assign results = concat([1], [2, 3, 4], 5)/>
<#list results as result>
  ${result}
</#list>

Output:
1
2
3
4 
5
```

## every
```
<#function isOver18 user>
  <#return user.age > 18>
</#function>
<#assign users = [
  {"id": 1, "name": "Franklin", "age": 21}, 
  {"id": 2, "name": "Jessica", "age": 15}, 
  {"id": 3, "name": "Justin", "age": 21}
]/>
<#assign allAdults = every(users, isOver18)/>

All adults? ${allAdults?string}

Output:
All adults? false
```

## filter

**Note**: `filter` will pass the item and index as arguments to the function so you must include those in your function declaration to avoid Freemarker throwing an insufficient arguments error. 
```
<#function over18 item i>
  <#return item.age > 18>
</#function>
<#assign users = [
  {"id": 1, "name": "Franklin", "age": 21}, 
  {"id": 2, "name": "Jessica", "age": 15}, 
  {"id": 3, "name": "Justin", "age": 21}
]/>
<#assign results = filter(users, over18)/>
<#list results as result>
  ${result}
</#list>

Output:
Franklin
Justin
```

## find
**Note**: If not found, will return `-1`.
```
<#function getJustin item>
  <#return item.name == "Justin">
</#function>
<#assign users = [
  {"id": 1, "name": "Franklin"}, 
  {"id": 2, "name": "Jessica"}, 
  {"id": 3, "name": "Justin"}
]/>
<#assign user = find(users, getJustin)/>

User: ${user.id} - ${user.name}

Output: 
User: 3 - Justin
```

## includes
```
<#function ronnieIncluded user>
  <#return user.name == "Ronnie">
</#function>
<#assign nums = [1, 2, 3, 4]/>
<#assign users = [
  {"id": 1, "name": "Franklin"}, 
  {"id": 2, "name": "Jessica"}, 
  {"id": 3, "name": "Justin"}
]/>

Is 2 in there? ${includes(nums, 2)?string}
Is Ronnie in there? ${includes(users, ronnieIncluded)?string}

Output:
Is 2 in there? true
Is Ronnie in there? false
```

## map

**Note**: `map` will pass the item and index as arguments to the function so you must include those in your function declaration to avoid Freemarker throwing an insufficient arguments error. 
```
<#function getName user i>
  <#return user.name>
</#function>
<#assign users = [
  {"id": 1, "name": "Franklin"}, 
  {"id": 2, "name": "Jessica"}, 
  {"id": 3, "name": "Justin"}
]/>
<#assign results = map(users, getName)/>
<#list results as result>
  ${result}
</#list>

Output:
Franklin
Jessica
Justin
```

## reduce

**Note**: `reduce` will pass the accumulator, current item, and index as arguments to the function so you must include those in your function declaration to avoid Freemarker throwing an insufficient arguments error. 
```
<#function sum acc curr i>
  <#return acc + curr>
</#function>
<#assign nums = [1, 2, 3, 4]/>
<#assign total = reduce(nums, sum)/>

Total: ${total}

Output:
Total: 10
```

## slice
```
<#assign items = ['foo', 'bar', 'baz', 'last']/>
<#assign results = slice(items, -2)/>
<#list results as result>
  ${result}
</#list>

Output:
baz
last
```

## some
```
<#function isOver18 user>
  <#return user.age > 18>
</#function>
<#assign users = [
  {"id": 1, "name": "Franklin", "age": 21}, 
  {"id": 2, "name": "Jessica", "age": 15}, 
  {"id": 3, "name": "Justin", "age": 21}
]/>
<#assign someAdults = some(users, isOver18)/>

Some adults? ${someAdults?string}

Output:
Some adults? true
```