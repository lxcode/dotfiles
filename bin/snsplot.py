#! /usr/bin/env python3

# %% Setup
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

title = ""


sns.set(font="Noto Sans CJK TC")
sns.set(font_scale=0.8)
sns.set_palette("deep")
plt.rcParams["axes.labelweight"] = "bold"
plt.rcParams["axes.titleweight"] = "bold"
plt.rcParams["axes.titlesize"] = 10
plt.rcParams["figure.autolayout"] = True

data_csv = "/tmp/in.csv"
df = pd.read_csv(data_csv)
df.columns = ["date", "tag", "count", "pct", "hist"]
df["date"] = pd.to_datetime(df["date"])
print(df.head())


# %% Calculate top values, remove rest from a tmp dataframe
top = 8
toptags = df.tag.value_counts()[:top]
threshold = toptags.values[top - 1:top][0]

tmpdf = df
tmpdf = tmpdf.set_index("date")
s = tmpdf.tag.value_counts().gt(threshold)
tmpdf = tmpdf.loc[tmpdf.tag.isin(s[s].index)]


# %% Horizontal bars
plt.figure(figsize=(10, 6))
plt.title(title)
ylabel = "User"

sns.countplot(
    y="tag", data=df, order=df.tag.value_counts().iloc[:top].index
).set_ylabel(ylabel)

plt.savefig("/tmp/snsbar.png", dpi=300, transparent=True)
plt.savefig("/tmp/snsbar.pdf")


# %% Scatter plot
plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.scatterplot(
    x="date",
    y="count",
    hue="tag",
    hue_order=df.tag.value_counts().iloc[:top].index,
    data=tmpdf,
    s=5,
    linewidth=0,
).legend().set_title = (None)

plt.savefig("/tmp/snsplot.png", dpi=300, transparent=True)
plt.savefig("/tmp/snsplot.pdf")


# %% Line plot
# If dealing with minute resolution data, resample as desired
ldf = tmpdf
ldf = tmpdf.groupby("tag").resample("H").mean()
ldf["count"] = ldf["count"].fillna(0)

plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.lineplot(
    x="date",
    y="count",
    linewidth=1,
    hue_order=df.tag.value_counts().iloc[:top].index,
    hue="tag",
    data=ldf,
).legend().set_title = (None)

plt.savefig("/tmp/snsline.png", dpi=300, transparent=True)
plt.savefig("/tmp/snsline.pdf")


# %% Histplot
# Just general activity in the dataset
plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.histplot(x="date", data=df, kde=True, bins=666)

plt.savefig("/tmp/snsdist.png", dpi=300, transparent=True)
plt.savefig("/tmp/snsdist.pdf")
