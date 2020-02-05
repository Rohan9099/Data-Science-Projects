A dataset collected in a cosmetics shop showing details of customers and whether or not
they responded to a special offer to buy a new lip-stick is shown in table below. Use this
dataset to build a decision tree, with Buys as the target variable, to help in buying lipsticks in the future. Find the root node of decision tree. According to the decision tree you
have made from previous training data set, what is the decision for the test data:
[Age < 21, Income = Low, Gender = Female, Marital Status = Married]?





import pandas as pd
from sklearn.preprocessing import LabelEncoder

# Importing the dataset
dataset = pd.read_csv('cosmetics.csv')

le = LabelEncoder()
data = dataset.apply(le.fit_transform)

from sklearn.model_selection import train_test_split

x = data.iloc[:,0:4]
y = data.iloc[:,-1]

x_train, x_test, y_train, y_test = train_test_split(x,y,test_size=0.5,random_state=0)
from sklearn import tree
decision_tree = tree.DecisionTreeClassifier()
decision_tree = decision_tree.fit(x,y)
decision_tree.score(x,y)
predicted = decision_tree.predict(x_test)
print(predicted)

from sklearn.externals.six import StringIO
from IPython.display import Image
from sklearn.tree import export_graphviz
import pydotplus
dot_data = StringIO()
export_graphviz(decision_tree, out_file=dot_data,
                filled=True, rounded=True,
                special_characters=True)
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
Image(graph.create_png())

