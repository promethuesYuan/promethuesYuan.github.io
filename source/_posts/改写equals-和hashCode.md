---
title: 改写equals()和hashCode()
date: 2020-03-19 22:43:09
tags: Java
categories: Java SE

---

<center>
    如何改写equals()和hashCode()方法
</center>

<!--more-->

## equals

Object类中的equals方法用于检测一个对象是否等于另外一个对象。在Object类中，这个方法将判断两个对象是否具有相同的引用。如果两个对象具有相同的引用，他们一定是相等的。然而，经常需要检测两个对象状态的相等性，如果两个对象的状态相等，就认为这两个对象是相等的。

equals具有下面的特性：

1. 自反性：对任何非空引用x，x.equals(x)应该返回true
2. 对称性：对任何非空引用x和y，当且仅当y.equals(x)返回true，x.equals(y)也应该返回true
3. 传递性
4. 一致性：如果x和y引用的对象没有发生变化呢，反复调用应该返回相同的结果
5. 对任意非空引用x,x.equals(null)应该返回false

编写equals的建议（放在下面的代码中）

```java
public class Employee {
    private String name;
    private double salary;
    private LocalDate hireDay;

    public Employee(String name, double salary, int year, int month, int day){
        this.name = name;
        this.salary = salary;
        hireDay = LocalDate.of(year, month, day);
    }

    public String getName(){
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public LocalDate getHireDay(){
        return hireDay;
    }


    public void raiseSalary(double percent){
        salary = salary * (1 + percent/100);
    }

    public boolean equals(Object otherObject){
        if(this == otherObject) return true;
        if(otherObject == null) return false;
        if(getClass() != otherObject.getClass()) return false;

        Employee other = (Employee) otherObject;

        return Objects.equals(name, other.name) && salary == other.salary && Objects.equals(hireDay, other.hireDay);
    }

    public int hashCode(){
        return Objects.hash(name, salary, hireDay);
    }

    public String toString(){
        return getClass().getName() + "[name=" + name + " ,salary=" + salary + " ,hireDay=" + hireDay +"]";
    }
}
```

```java
public class Manager extends Employee {
    private double bonus;

    public Manager(String name, double salary, int year, int month, int day){
        super(name, salary, year, month, day);
        bonus = 0;
    }

    public double getSalary(){
        return super.getSalary() + bonus;
    }

    public void setBonus(double b){
        bonus = b;
    }

    public boolean equals(Object otherObject){
        if(!super.equals(otherObject)) return false;

        Manager other = (Manager) otherObject;

        return bonus == other.bonus;
    }

    public int hashCode(){
        return super.hashCode() + 17*Double.hashCode(bonus);
    }

    public String toString(){
        return super.toString() + "[bonus=" + bonus + "]";
    }
}
```

```java
public class EqualsTest {
    public static void main(String[] args) {
        Employee alice1 = new Employee("Alice Adams", 75000, 1987, 12, 15);
        Employee alice2 = alice1;
        Employee alice3 = new Employee("Alice Adams", 75000, 1987, 12, 15);
        Employee bob = new Employee("Bob Brandson",50000, 1989, 10, 1);

        System.out.println("alice1 == alice2:" + (alice1 == alice2));//true
        System.out.println("alice1 == alice3:" + (alice1 == alice3));//false
        System.out.println("alice1.equals(alice3):" + (alice1.equals(alice3)));//true
        System.out.println("alice1.equals(bob):" + (alice1.equals(bob)));//false
        System.out.println("bob.toString:" + bob);

        Manager carl = new Manager("Carl Cracker", 80000,1987,12,15);
        Manager boss = new Manager("Carl Cracker", 80000,1987,12,15);
        boss.setBonus(5000);

        System.out.println("boos.toString():" + boss);
        System.out.println("carl.equals(boss):" + carl.equals(boss));
        System.out.println("alice1.hashCode():" + alice1.hashCode());
        System.out.println("alice3.hashCode():" + alice3.hashCode());
        System.out.println("bob.hashCode():" + bob.hashCode());
        System.out.println("carl.hashCode():" + carl.hashCode());


    }
}
```



## equals 和 ==的区别

对于 **== 来说比较两个对象时，实质上是检查对象的内存地址是否相等**

原生Objects.equals其实也是这么干的



## 为什么要重写hashCode()

原生hashCode方法到处的是对象存储地址。

由于定义equals与hashCode的定义必须一致：如果x.equals(y) 返回true，那么x.hashCode()必须等于y.hashCode()。所以当我们修改了equals方法后，应该也修改hashCode方法。