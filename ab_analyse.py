import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from statsmodels.stats.proportion import proportions_ztest

groups = ['Группа A\n(Контроль)', 'Группа B\n(Тест)']
conversions = [49.81, 64.40]


plt.figure(figsize=(8, 6))
sns.set_theme(style="whitegrid")


bars = plt.bar(groups, conversions, color=['orange', 'skyblue'], width=0.5)

for bar in bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2.0, yval + 1, f'{yval}%', ha='center', va='bottom', fontsize=12, fontweight='bold')

plt.title('Конверсия из шага 1 (открытие формы) в шаг 4 (успешная оплата)', fontsize=14)
plt.ylabel('Уровень конверсии, %', fontsize=12)
plt.ylim(0, 80)

plt.tight_layout()
plt.savefig('ab_test_result.png', dpi=300)
plt.show()


success_a, total_a = 652, 1309
success_b, total_b = 870, 1351

count = np.array([success_a, success_b])
nobs = np.array([total_a, total_b])

z_stat, p_value = proportions_ztest(count, nobs)
print(f"Z-статистика: {z_stat:.3f}")
print(f"p-value: {p_value:.5f}")